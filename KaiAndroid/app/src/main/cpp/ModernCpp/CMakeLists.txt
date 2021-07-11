
aux_source_directory(. DIR_MODERN_CPP_SRCS)
#file(GLOB DIR_MODERN_CPP_SRCS "src/f[1-3].cpp")

list(REMOVE_ITEM DIR_MODERN_CPP_SRCS "./ShapeXxx.cpp")

message("in ModernCpp/CMakeLists.txt DIR_MODERN_CPP_SRCS=${DIR_MODERN_CPP_SRCS}")

add_library(libModernCpp ${DIR_MODERN_CPP_SRCS} leftright.cpp leftright.h usability.cpp usability.h pointers.cpp pointers.h regextest.cpp regextest.h
        teststd17.cpp teststd17.h stringformat.cpp stringformat.h)
