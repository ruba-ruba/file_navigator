require 'pry'

hash = {
          'movies' => {
            'action' => {
              '2007' => ['video1.avi', 'x.wmv'],
              '2008' => {
                'summer' => [],
                'winter' => ['winter.avi']
              }
            },
            'comedy' => {
              '2007' => [],
              '2008' => ['y.avi']
            }
          },
          'audio' => {
            'rock' => {
              '2003' => [],
              '2004' => ['group', 'group1'],
              '2008' => ['group2'] 
            },
            'pop' => {
              '2003' => {
                'g1' => ['s1.mp3', 's3.mp3'],
                'g2' => ['s2.mp3'],
                'g3' => []
              }
            }
          }
        }

def tree(obj, root = nil)
  result = [root]
  obj.each do |folder, subfolders|
    parent = [root, folder].compact.join('/')
    result << tree(subfolders, parent)
  end if obj
  result.compact.flatten
end

if File.identical?(__FILE__, $0)  
  puts tree(hash)
end

#expected result

# moviews
# moviews\action
# moviews\action\2007
# moviews\action\2007\video1.avi
# moviews\action\2007\x.wmv
# moviews\action\2008
# moviews\comedy\2007
# moviews\comedy\2008
# moviews\comedy\2008\y.avi
# audio
# audio\rock\2003
# audio\rock\2004
# audio\rock\2004\group
# audio\rock\2004\group1
# audio\rock\2008
# audio\rock\2008\group2
# audio\pop\2003