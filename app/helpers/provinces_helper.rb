module ProvincesHelper
  def decimals(a)
    num = 0
    while (a != a.to_i)
      num += 1
      a *= 10
    end
    num
  end

  def rounding(b)
    decimals(b) == 2 ? (b * 100).to_i / 100.0 : (b * 100_000).to_i / 100_000.0
  end
end
