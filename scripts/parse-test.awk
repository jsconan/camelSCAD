#
# MIT License
#
# Copyright (c) 2017-2022 Jean-Sebastien CONAN
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

#
# Part of the camelSCAD library.
#
# Parses and displays the results of the unit tests.
#
# @package util/test
# @author jsconan
#

BEGIN {
    # will parse a CSV file
    FS = ";"

    # init counters
    packageCount = 0
    moduleCount  = 0
    assertCount  = 0
    successCount = 0
    failedCount  = 0
    warningCount = 0
    errorCount   = 0
    indexCount   = 0

    # define ANSI colors
    BLACK    = "\033[0;30m"
    GRAY     = "\033[1;30m"
    RED      = "\033[0;31m"
    LRED     = "\033[1;31m"
    GREEN    = "\033[0;32m"
    LGREEN   = "\033[1;32m"
    BROWN    = "\033[0;33m"
    YELLOW   = "\033[1;33m"
    BLUE     = "\033[0;34m"
    LBLUE    = "\033[1;34m"
    MAGENTA  = "\033[0;35m"
    LMAGENTA = "\033[1;35m"
    CYAN     = "\033[0;36m"
    LCYAN    = "\033[1;36m"
    GREY     = "\033[0;37m"
    WHITE    = "\033[1;37m"
    RESET    = "\033[0m"
}

# detect compiler errors
$0~/^ERROR:/ {
    errorCount = errorCount + 1
    printf("\n%s%s\n", LRED, $0)
}
# detect compiler warnings
$0~/^WARNING:/ {
    warningCount = warningCount + 1
    printf("\n%s%s\n", LRED, $0)
}

# detect package declarations
$1~/package/ {
    packageCount = packageCount + 1
    package = $2
    lastType = "package"
    printf("\n%s[%s] ", LBLUE, $2)
}

# detect module declarations
$1~/module/ {
    moduleCount = moduleCount + 1
    module = $2
    lastType = "module"
    printf("\n%s    %s ", CYAN, $2)
}

# detect assertion results
$1~/assert/ {
    if (lastContext != $3) {
        indexCount = 0
    }
    lastContext = $3
    indexCount = indexCount + 1
    assertCount = assertCount + 1
    lastType = "assert"

    if ($2 == "#OK") {
        # successful assertion
        successCount = successCount + 1
        printf("%s.", LGREEN)
    } else {
        # failed assertion
        failedAsserts[failedCount] = $0
        failedAssertsIndex[failedCount] = indexCount
        failedAssertsPackage[failedCount] = package
        failedAssertsModule[failedCount] = module
        failedAssertsContext[failedCount] = $3
        failedAssertsMessage[failedCount] = $4
        failedAssertsDetails[failedCount] = $5
        failedCount = failedCount + 1

        # notify the failed assertion
        printf("%sF", LRED)
    }
}

# detect assertions counters
$1~/expect/ {
    # is failed count ?
    if ($5 != "true") {
        if ($3 == "") {
            # no expected number, try to take the actual number
            if (!$4) {
                # no actual number, assume it is at least 1
                expected = 1
            } else {
                # take the actual number as the expected number
                expected = $4
            }
        } else {
            # provided expected number
            expected = $3
        }

        failedAsserts[failedCount] = $0
        failedAssertsPackage[failedCount] = package
        failedAssertsModule[failedCount] = module
        failedAssertsContext[failedCount] = $6
        failedAssertsMessage[failedCount] = $7
        assertCount = assertCount + expected - $4
        failedCount = failedCount + 1

        # put a space after package name in case of some result will be displayed after
        if ($2 == "package") {
            printf(" ")
        }

        # if the last was a module, the result need to be displayed on a new line
        if ($2 == "module") {
            printf("\n    ")
        }

        # notify the missing assertions
        printf("%sM", LRED)
        indexCount = 0
    }
}

END {
    separator = "%s-----------\n"
    printf("\n")

    if (failedCount > 0) {
        printf(separator, GREY)
        printf("%sFAILED\n", RED)
        package = ""
        context = ""

        for (i = 0; i < failedCount; i++) {
            if (package != failedAssertsPackage[i]) {
                package = failedAssertsPackage[i]
                printf("%s[%s]\n", GRAY, package)
            }
            if (failedAssertsContext[i] && context != failedAssertsContext[i]) {
                context = failedAssertsContext[i]
                printf("%s  %s\n", MAGENTA, context)
            }
            if (failedAssertsContext[i]) {
                printf("  ")
            }
            if (failedAssertsIndex[i]) {
                printf("%s- #%d: %s\n", RED, failedAssertsIndex[i], failedAssertsMessage[i])
            } else {
                printf("%s- %s\n", RED, failedAssertsMessage[i])
            }
            if (failedAssertsDetails[i]) {
                details = failedAssertsDetails[i];
                while(match(details, /\{([^:]+):\s?([^\}]+)\}/) != 0) {
                    if (RSTART > 0) {
                        detailsPrefix = substr(details, 0, RSTART - 1)
                    } else {
                        detailsPrefix = ""
                    }
                    detailsBody = substr(details, RSTART + 1, RLENGTH - 2)
                    detailsSuffix = substr(details, RSTART + RLENGTH)

                    if (match(detailsBody, /[a-z]+:/) != 0) {
                        detailsBody = sprintf("%s%s%s%s", CYAN, substr(detailsBody, RSTART, RLENGTH), BROWN, substr(detailsBody, RSTART + RLENGTH)) 
                    }
                    details = sprintf("%s    %s\n%s", detailsPrefix, detailsBody, detailsSuffix) 
                }
                printf("%s", details)
            }
            printf("\n")
        }
    }

    printf(separator, GREY)
    printf("%s%d packages\n", GREEN, packageCount)
    printf("%s%d modules\n", GREEN, moduleCount)
    printf("%s%d/%d asserts\n", GREEN, successCount, assertCount)
    printf(separator, GREY)

    if (errorCount > 0) {
        printf("%s%d errors!\n", RED, errorCount)
    }
    if (warningCount > 0) {
        printf("%s%d warnings!\n", RED, warningCount)
    }

    if (failedCount == 0) {
        printf("%sAll successful!\n", GREEN)
    } else {
        printf("%s%d failed asserts!\n", RED, failedCount)
    }
}
