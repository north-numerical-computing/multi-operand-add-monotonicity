% multi_term_add0.m  Simulation of multi-term non-monotonic adders.
%   This code uses the chop/CPFloat libraries for simulating custom
%   precision floating-point arithmetics.
%
%   Reference: M. Mikaitis. Monotonicity of multi-term floating-point
%              adders. 2023.

function s = multi_term_add0(x, options)

  % Find an addend with a maximum magnitude.
  max = 1;
  for i = 1:length(x)
      if abs(x(i)) > abs(x(max))
          max = i;
      end
  end

  params = options.params;
  s = x(max);

  % Calculate the next power of 2 after x(max).
  next_power_two = 2^(ceil(log2(s)));
  if (s == next_power_two)
      next_power_two = 2^(log2(s)+1);
  end

  % Add numbers, increase precision when crossing the powers of two.
  for i = 1:length(x)
      if (i ~= max)
          s = s + x(i);
      end
      if (s >= next_power_two)
          options.params(1) = options.params(1) + 1;
          next_power_two = 2^(ceil(log2(s)));
          if (s == next_power_two)
              next_power_two = 2^(log2(s)+1);
          end
      end
      s = cpfloat(s, options);
  end

  % Reset original precision (of the arguments) and round the result.
  options.params = params;
  s = cpfloat(s, options);
end