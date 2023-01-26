% multi_term_add1.m  Simulation of IEEE 754 multi-term addition.
%   This code uses the chop/CPFloat libraries for simulating custom
%   precision floating-point arithmetics.
%
%   Reference: M. Mikaitis. Monotonicity of multi-term floating-point
%              adders. 2023.

function s = multi_term_add1(x, options)

  s = 0;
  for i = 1:length(x)
          s = cpfloat(s + x(i), options);
  end
end