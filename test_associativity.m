% test_associativity.m  Test associativity of multi-term adders.
%   This code uses the chop/CPFloat libraries for simulating custom
%   precision floating-point arithmetics.
%
%   Reference: M. Mikaitis. Monotonicity of multi-term floating-point
%              adders. 2023.

clear all
% Create a stream of pseudo-random numbers.
s = RandStream('mrg32k3a', 'seed', 500);

% Terms in the multi-term adder.
T = 64;

% Permutations of vector to sum.
P = 10000;

% Set up the working floating-point arithmetic.
options.format = 'c';
options.subnormal = 1;
options.round = 1;
options.params = [11, 15];
cpfloat([], options);

random_values = cpfloat(rand(s, T, 1), options);

sum_ieee754 = zeros(P,1);
sum_multi_term_adder = zeros(P,1);
sum_double = sum(random_values);

for i = 1:P
    random_values = random_values(randperm(T));
    for j = 1:T
        sum_ieee754(i) = cpfloat(sum_ieee754(i) + random_values(j), options);
    end
    sum_multi_term_adder(i) = multi_term_add0(random_values, options);
end

% Check the ranges of sums computed. Range is zero if arithmetic is
% associative.
range(sum_ieee754)
range(sum_multi_term_adder)

