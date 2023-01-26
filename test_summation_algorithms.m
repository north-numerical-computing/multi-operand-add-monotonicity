% test_summation_algorithms.m  Test various summation algorithms.
%   This code uses the chop/CPFloat libraries for simulating custom
%   precision floating-point arithmetics.
%
%   Reference: M. Mikaitis. Monotonicity of multi-term floating-point
%              adders. 2023.

clear all
% Create a stream of pseudo-random numbers.
s = RandStream('mrg32k3a', 'seed', 500);

% Set up the number of terms in multi-term adder.
T = [4, 64, 512, 1024];
% Set up the lengths of the vectors to sum.
N = [1024, 2048, 3072, 4096, 5120, 6144, 7168, 8192, 9216, 10240, 16384];

errors = [];

% Set up the working floating-point arithmetic.
options.format = 'c';
options.subnormal = 1;
options.round = 1;
options.params = [11, 15];
cpfloat([], options);

for k = 1:length(T)
    for j = 1:length(N)
        % A vector of random values for summing.
        reset(s);
        random_values = cpfloat(rand(s, N(j), 1)*0.001, options);
        random_values_inc = sort(random_values);
        random_values_dec = sort(random_values, 'descend');
        
        sum_double_recursive = 0;
        sum_inc_order = 0;
        sum_dec_order = 0;
        sum_multi_term_adder = 0;
        
        % Perform addition in the T-term adders.
        for i = 1:T(k):N(j)
            if (i==1)
                inputs = [0, random_values(1:T(k)-1)'];
            else
                inputs = [sum_multi_term_adder, ...
                    random_values(i:i+T(k)-1)'];
            end
            sum_multi_term_adder = multi_term_add0(inputs, options);
        end
            
        for i = 1:N(j)
            sum_double_recursive = sum_double_recursive + random_values(i);
            sum_inc_order = cpfloat(sum_inc_order + random_values_inc(i));
            sum_dec_order = cpfloat(sum_dec_order + random_values_dec(i));
        end

        errors(1, j) = sum_double_recursive;
        errors(2, j) = abs(sum_double_recursive-sum_inc_order)/ ...
            sum_double_recursive;
        errors(3, j) = abs(sum_double_recursive-sum_dec_order)/ ...
            sum_double_recursive;
        errors(4, j) = abs(sum_double_recursive-sum_multi_term_adder)/ ...
            sum_double_recursive;
    end

    % Write sum values and errors to .dat files.
    filename = strcat('compare_summation_algs_terms', ...
                       num2str(T(k)), '.dat');
    fileID = fopen(filename, 'w');
    fprintf(fileID, ...
        ['length fp16-inc-ord fp16-dec-ord fp16-multi-term-add \n']);
    for i=1:length(N)
        fprintf(fileID,'%.10f %.10f %.10f %.10f \n', ...
            N(i), errors(2, i), errors(3, i), errors(4, i));
    end

    figure
    h = plot(N, errors(2, :), '--', ...
             N, errors(3, :), '--', ...
             N, errors(4, :), '--');
    xlabel('number of addends')
    ylabel('Relative error')
    grid
    legend('fp16 inc. order', ...
           'fp16 dec. order', 'fp16 multi-operand')
    set(h,'LineWidth',1.5)
end