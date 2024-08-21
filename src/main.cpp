#include <my_format.hpp>

template<typename T>
void print_single(T t) {
    std::cout << t << std::endl;
}

template<typename... Args>
void print(Args... args) {
    (print_single(args), ...);
}

int main() {
    print(1, 2.5, "Hello, World!");
    return 0;
}