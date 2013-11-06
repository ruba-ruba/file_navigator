require 'benchmark'
require 'pry'

F = Struct.new(:name, :size) do
  def grouping
    "#{name}/#{size}"
  end
end

N = 1

files = []
1000.times { files << F.new("#{%w(a b c d e).sample}.txt", (1..5).to_a.sample) }

def test_duplicates_original(files)
  result = {}

  names = []
  files.each do |f|
    names << [f.name, f.size]
  end

  duplicates = names.select{|item| names.count(item) > 1}.uniq

  dup_hash_keys = duplicates.flatten
  name_keys = dup_hash_keys.values_at(*dup_hash_keys.each_index.select {|i| i.even?})


  dup_files = []
  files.each do |file|
    dup_files << file if duplicates.include?([file.name, file.size])
  end


  name_keys.each do |key|
    result[key] = []
    dup_files.each do |file|
      result[key] << file if file.name == key && !file.nil? && !key.nil?
    end
  end
  
  result
end
 
def test_duplicates_optimized(files)
  result = {}
  names = files.collect{|f| [f.name, f.size]}
  duplicates = names.select{|item| names.count(item) > 1}.uniq
  dup_hash_keys = duplicates.flatten
  name_keys = dup_hash_keys.values_at(*dup_hash_keys.each_index.select {|i| i.even?})
  dup_files = files.select{|i| duplicates.include?([i.name, i.size])}
  name_keys.each do |key|
    result[key] = dup_files.select{|f| f.name == key }
  end
  result
end

def test_inject(files)
 files.group_by{|e|"#{e.name}/#{e.size}"}.inject({}){|res, (k, v)| res[k.split('/')[0]] ||=[]; res[k.split('/')[0]] << v if v.size > 1; res}
end

def test_duplicates2(files)
  result = {}
  files.each do |file|
    result[file.name] ||= []
    result[file.name] << files.select{|f| f.size == file.size && file.name == f.name}
  end

  result.each do |key, val|
    result[key] = val.select{|i| val.count(i) > 1}.uniq.flatten
  end

  result = result.reject{|k,v| v.empty? }
  result
end



a = test_duplicates_original(files)
b = test_duplicates_optimized(files)
c = test_duplicates2(files)
d = test_inject(files)

# puts files
 puts c 
 puts "____________________________qq"
 puts d
#raise "c != d" unless c == d


Benchmark.bm do |x|
  x.report("my_method original")  { N.times { test_duplicates_original(files) } }
  x.report("my_method optimized") { N.times { test_duplicates_optimized(files) } }
  x.report("test_duplicates2")    { N.times { test_duplicates2(files) } }

  x.report("inject")    { N.times { test_inject(files) } }
end




























  # def self.duplicates(files)
  #   result = {}

  #   names = []
  #   files.each do |f|
  #     names << [f.item_file_name, f.item_file_size]
  #   end

  #   duplicates = names.select{|item| names.count(item) > 1}.uniq

  #   dup_hash_keys = duplicates.flatten
  #   name_keys = dup_hash_keys.values_at(* dup_hash_keys.each_index.select {|i| i.even?})


  #   dup_files = []
  #   files.each do |file|
  #     dup_files << file if duplicates.include?([file.item_file_name, file.item_file_size])
  #   end

  #   name_keys.each do |key|
  #     result[key] = []
  #     dup_files.each do |file|
  #       result[key] << file if file.item_file_name == key && !file.nil? && !key.nil?
  #     end
  #   end
    
  #   result
  # end

