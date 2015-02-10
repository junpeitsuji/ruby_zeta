require 'Complex'
require 'prime'
require './binom'


# 複素変数 s に対するリーマン・ゼータ関数を計算する関数
LOWER_THRESHOLD=1.0e-6
UPPER_BOUND=1.0e+4
MAXNUM=300

def zeta(s)
	outer_sum = 0
	prev = 1000000000

	for m in 1..MAXNUM do

		# inner_sum を計算する
		#   = 2^{-m} \sum_{j=1}^{m} (-1)^{j-1} \comb{m-1, j-1} \frac{j^{-s}}{1-2^{1-s}}
		inner_sum = 0
		for j in 1..m do
			c1 = ((j-1)%2==0) ? 1 : (-1)  # (-1)**(j-1) と等価。計算を簡略化した。
			c2 = binom(m-1, j-1)
			c3 = j**(-s)
			inner_sum += c1*c2*c3
		end
		inner_sum = inner_sum * (2**(-m)) / (1-2**(1-s))

		# 和に加える
		outer_sum += inner_sum

		# 差が閾値以下であれば「収束した」と判断して計算を終了する
		if (prev - inner_sum).abs < LOWER_THRESHOLD then
			break
		end

		# 大きな値は上記の収束判定がきかないため、UPPER_BOUND を超えると「打ち止め」して計算を終了する
		if outer_sum.abs > UPPER_BOUND then
			break
		end

		prev = inner_sum
	end

	outer_sum
end


### ゼータ関数のクリティカル・ライン周辺の値を計算する
def zeta_main 
	File.open("commplex-plane.csv", "w") do |io|
		# 虚軸方向に 0.1 おきに [0.0, 40.0] の範囲で計算 
		(-40.0).step(40.0, 0.1) do |y|

			# 実軸方向に 0.1 おきに [-20.0, 20.0] の範囲で計算 
			# (ただし s=1 で「ゼロ割り」が発生するので、実軸方向の初期値を若干ずらしている。)
			(-40.00001).step(40.0, 0.1) do |x|  

				s = x + Complex::I*y  # x+iy
				z = zeta(s)

				column = "#{x},#{y},#{z.real},#{z.imag},#{z.abs},#{z.arg}"

				io.puts column
				puts column
			end
			io.puts ""
			puts ""
		end
	end
end

### ゼータ関数のクリティカル・ライン上の値を計算する
def zeta_main_2
	File.open("critical-line.csv", "w") do |io|
		# クリティカル・ライン上を，実軸から離れる方向に， 0.05 おきに計算する．
		# t = 0 から t = 100 まで 
		0.step(100.0, 0.05) do |t|  

			s = 0.5 + Complex::I*t  # 1/2+it
			z = zeta(s)

			column = "#{s.real},#{s.imag},#{z.real},#{z.imag},#{z.abs},#{z.arg}"

			io.puts column
			puts column
		end
	end
end

### 以下の処理を実行する
zeta_main
zeta_main_2
