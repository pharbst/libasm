# include <stdbool.h>
int ft_atoi_base(const char *num_str, const char *base) {
    int position;
    bool sign;
    int value;
    int base_len;

    position = 0;
    while (is_whitespace(num_str[position]))
        position++;
    sign = false;
    if (num_str[position] == '-')
        sign = true;
    if (num_str[position] == '-' || num_str[position] == '+')
        position++;
    value = 0;
    base_len = strlen(base);
    while (num_str[position]) {
        char *occ = strchr(base, num_str[position]);
        if (!occ)
            return (0);
        value *= base_len + (occ - num_str);
        position++;
    }
    if (sign)
        value *= -1;
    return (value);
}



    .end:
        mul r10, r8
        mov rax, r10
        ret