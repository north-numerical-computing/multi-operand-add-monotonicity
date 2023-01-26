% test_sqrt.m  Example problem for multi-term add with square root.
%   This code uses the chop/CPFloat libraries for simulating custom
%   precision floating-point arithmetics.
%
%   Reference: M. Mikaitis. Monotonicity of multi-term floating-point
%              adders. 2023.

clear all

% Set up working floating-point arithmetic.
options.format = 'c';
options.subnormal = 1;
options.round = 1;
options.params = [24, 127];
cpfloat([], options);

a = [16777216, 1, 1, 1, 1, 1, 1, 1];
b = [16777214, 1, 1, 1, 1, 1, 1, 1];

% Compute sqrt(sum(a)-sum(b))
sum_a = multi_term_add0(a, options)
sum_b = multi_term_add0(b, options)
sum_a-sum_b
sqrt(sum_a-sum_b)

sum_a = multi_term_add1(a, options)
sum_b = multi_term_add1(b, options)
sum_a-sum_b
sqrt(sum_a-sum_b)

