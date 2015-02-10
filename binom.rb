require 'benchmark'


_MAXNUM=1000

#=begin
# 二項係数 nCk を計算する関数 ver.1
def binom_v1(n,k)
	if k==0 then
		return 1
	elsif n==k then
		return 1
	else
		return binom_v1(n-1,k-1)+binom_v1(n-1,k)
	end
end
#=end

#=begin
# 二項係数 nCk を計算する関数 ver.2
def binom_v2(n,k)
	k = [k, n-k].min

	if k==0 then
		val = 1
	else
		val = binom_v2(n-1,k-1)*n/k
	end

	return val
end
#=end


#=begin
$array = Array.new(_MAXNUM+1).map{Array.new(_MAXNUM+1, 0)}

# 二項係数 nCk を計算する関数 ver.3
#    既に計算した値は, 二次元配列 $array に格納されて次回呼び出し時に使用される 
def binom_v3(n,k)
	if $array[n][k] == 0 then
		k = [k, n-k].min

		if k==0 then
			val = 1
		else
			val = binom_v3(n-1,k-1)*n/k
		end

		$array[n][k] = val
		return val

	else
		return $array[n][k]
	end
end
#=end


# 二項係数 nCk を計算する関数
def binom n,k
	#binom_v1 n,k
	#binom_v2 n,k
	binom_v3 n,k
end


### ベンチマークテスト
##### ログデータは "benchmark.csv" に格納
def binom_test_1
	File.open("benchmark.csv", "w") do |io|
		30.times do |i|
			n = i
			k = i/2
			b = 0
			result = Benchmark.realtime do
				b = binom(n,k)
			end
			io.puts "#{n},#{k},#{b},#{result}"
		end
	end
end

### v1, v2, v3 のどちらのバージョンも同じ値を返すことの確認
def binom_test_2
	20.times do |n|
		(0..n).each do |k|

			b1 = binom_v1(n,k)
			b2 = binom_v2(n,k)
			b3 = binom_v3(n,k)

			if b1!=b2 || b1!=b3 || b2!=b3 then
				puts "#{b1},#{b2},#{b3}"
			end
		end
	end
end


### 実行テスト
#binom_test_1
#binom_test_2

