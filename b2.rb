require 'benchmark' 

module Enumerable
   def map_with_index
      index = -1
      (block_given? && self.class == Range || self.class == Array)  ?  map { |x| index += 1; yield(x, index) }  :  self
   end
end


class Array

   def find_dups
      inject(Hash.new(0)) { |h,e| h[e] += 1; h }.select { |k,v| v > 1 }.collect { |x| x.first }
   end


   # Based on hungryblank's version in the comments
   # see http://www.ruby-forum.com/topic/122008

   def find_dups2
      uniq.select{ |e| (self-[e]).size < self.size - 1 }
   end

   def find_ndups     # also returns the number of items
      uniq.map { |v| diff = (self.size - (self-[v]).size); (diff > 1) ? [v, diff] : nil}.compact
   end


   # cf. http://www.ruby-forum.com/topic/122008
   def dups_indices   
      (0...self.size).to_a - self.uniq.map{ |x| index(x) }
   end

   def dup_indices(obj)
      i = -1
      ret = map { |x| i += 1; x == obj ? i : nil }.compact
      #ret = map_with_index { |x,i| x == obj ? i : nil }.compact
      ret.shift
      ret
   end

   def delete_dups(obj)
      indices = dup_indices(obj)
      return self if indices.empty?
      indices.reverse.each { |i| self.delete_at(i) }
      self
   end

end  


array = [1,3,5,5,6,7,9,10,14,18,22,22,4,4,4,3,6]

dups = nil


Benchmark.bm(14) do |t| 

 t.report('find_dups:') do
    dups = array.find_dups
 end 

end 

p dups   #=> [5, 22, 6, 3, 4]


p %w(a b a c c d).dups_indices
p %w(a b a c c d).dup_indices('c')
p %w(a b a c c d).delete_dups('a')


