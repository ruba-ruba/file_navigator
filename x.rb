require 'benchmark'
require 'pry'
require 'awesome_print'

F = Struct.new(:name, :size) do
  def grouping
    "#{name}/#{size}"
  end
end

N = 3

files = []
3.times { files << F.new("#{%w(a b c).sample}.txt", (1..5).to_a.sample) }

files  = [F.new('a', 1), F.new('b', 1), F.new('a', 1), F.new('a', 2), F.new('a', 3), F.new('a', 3)]

def make_hash(files)
  result = {}
  files.each do |file|
    result[file.name] ||= []
    result[file.name] << files.select{|f| f.size == file.size && file.name == f.name}
  end

  result.each do |key, val|
    result[key] = val.select{|i| val.count(i) > 1}.uniq
  end

  result = result.reject{|k,v| v.empty? }
  result
end

def test_inject(files)
 files.group_by{|e|"#{e.name}/#{e.size}"}.inject({}){|res, (k, v)| res[k.split('/')[0]] = v if v.size > 1; res} 
end

ap files
ap '------------'
ap make_hash(files)
ap '------------'
ap test_inject(files)
