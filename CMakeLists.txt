cmake_minimum_required(VERSION 3.22)
project(my_format VERSION 0.0.1 LANGUAGES CXX)

# GENERATE THE LIB OBJECT
# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Add include directories
include_directories(${PROJECT_SOURCE_DIR}/include)


# Add source files excluding main.cpp
file(GLOB_RECURSE CPP_SOURCES "src/*.cpp")
list(FILTER CPP_SOURCES EXCLUDE REGEX ".*main\\.cpp$")

# Create an object library from the source files
add_library(my_formatObj OBJECT ${CPP_SOURCES})

# Include extern submodule cxxopts
add_subdirectory(extern/cxxopts)
target_include_directories(my_formatObj PUBLIC ${cxxopts_SOURCE_DIR}/include)

if(ENABLE_CFLAGS)
    target_compile_options(my_formatObj PRIVATE -fsanitize=address -Wall -Wextra -Werror)
    target_link_libraries(my_formatObj PRIVATE -fsanitize=address)
endif()


# Create the main executable with main.cpp
add_executable(my_format src/main.cpp)
target_link_libraries(my_format PRIVATE my_formatObj)