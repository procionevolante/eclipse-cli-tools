#!/bin/awk -f

# @brief convert a win/dos path to a WSL path
function dos2UnixPath(dosPath)
{
    gsub(/\\/, "/", dosPath)

    if (dosPath ~ /[c-zC-Z]:\//) { # absolute path
        drive = tolower(substr(dosPath, 1, 1))
        dosPath = substr(dosPath, 4) # remove starting "C:\"
        return "/mnt/" drive "/" dosPath ""
    }

    return dosPath
}

function processArg(arg)
{
    idx = match(arg, /['"]?[c-zC-Z]:[\/\\]/)
    if (idx == 0) {
        # TODO: maybe convert \ -> / ?
        return arg # argument doesn't contain a path
    }
    # convert path in arg and return processed argument
    ret = substr(arg, 1, idx - 1) # save string preceding path start
    path = substr(arg, idx)

    if (path ~ /^['"].*['"]$/) {
        quoteChar = substr(path, 1, 1)
        path = substr(path, 2, length(path) - 2)
    } else
        quoteChar = ""
    # not using wslpath bc from 2nd file starts returning const string
    #"wslpath -u " path | getline unixPath
    unixPath = dos2UnixPath(path)

    ret = ret "" quoteChar "" unixPath "" quoteChar

    return ret
}

{
    if ($1 !~ /arm-none-eabi-(gcc|clang|g\+\+)/)
        next

    for (i = 1; i <= NF; i++) {
        # in gcc & clang an argument in the form of `@file` means that
        # the arguments should be read from `file`
        if ($i ~ /^["']?@.*["']?$/)
        {
            # expand referenced file
            if ($i ~ /^["']/) # remove also quotes if present
                file = substr($i, 3, length($i) - 3)
            else
                file = substr($i, 2)
            while((getline line < file) > 0) {
                sub(/\r/, "", line) # remove fuckin windows' \r\n EOL
                printf("%s ", processArg(line))
            }
            close(file)
        } else {
            printf("%s ", processArg($i))
        }
    }
    print("")
}
