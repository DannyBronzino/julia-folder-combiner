# set variables
output_directory = ".//output"
input_files = []
split_name = ()
counter = 1
input_directories = []

# Reads directory names from commandline
if ARGS == []
    for item in readdir(".")
        if isdir(item) == true
            push!(input_directories, item)
        end
    end
else
    for arg in ARGS
        if isdir(arg) == true
            push!(input_directories, arg)
        else
            error("$arg is an invalid directory name.")
        end
    end
end

# in case the program has run already it deletes the old directory
# should be modified to ask if want to delete in case you made a mistake
rm(output_directory, force=true, recursive=true)
mkdir(output_directory)

# reads all the filenames into an array, could probably be modified to read
# files in subdirectories to flatten things, if you nasty
for directory in input_directories
    for file in readdir(directory)
        push!(input_files, "$directory//$file")
    end
end

# straight up combines this junk and assigns it a number
# works with all files, but maybe it should assign numbers relative to extension
for file in input_files
    global counter
    padded_counter = lpad(counter, 3, "0")
    split_name = splitext(file)
    ext = split_name[2]
    cp(file, "$output_directory//$padded_counter$ext")
    counter += 1
end

# removes input directories, but it should ask if you want to
# for directory in input_directories
#    rm(input_directories, force=true, recursive=true)
# end

println("Files placed in $output_directory")