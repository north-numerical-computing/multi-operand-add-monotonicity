% test_interval.m  Example in interval arithmetic with multi-term add.
%   This code uses the chop/CPFloat libraries for simulating custom
%   precision floating-point arithmetics.
%
%   Reference: M. Mikaitis. Monotonicity of multi-term floating-point
%              adders. 2023.

clear all

% Set up the working floating-point arithmetic.
options.format = 'c';
options.subnormal = 1;
options.round = 1;
options.params = [24, 127];
cpfloat([], options);

a = [16777216, 1, 1, 1, 1, 1, 1, 1];
b = [16777214, 1, 1, 1, 1, 1, 1, 1];

% Compute intervals of sum(a)
options.round = 3;
sum_a_bottom = multi_term_add0(a, options)
options.round = 2;
sum_a_top = multi_term_add0(a, options)

% Compute intervals of sum(b)
options.round = 3;
sum_b_bottom = multi_term_add0(b, options)
options.round = 2;
sum_b_top = multi_term_add0(b, options)

