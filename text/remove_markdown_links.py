import sys
import re
import codecs

content = '''
hello[world](https://world.com)!!
'''


content = sys.stdin.read()

pattern = r'\[(.*?)\]\(.*?\)'
new_content = re.sub(pattern, r'\1', content)

sys.stdout.write(new_content)



