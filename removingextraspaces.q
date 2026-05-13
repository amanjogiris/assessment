/ input string
s: " I am  currently solving a  KDB problem "

/ Split the string by spaces, remove empty elements (extra spaces), and join back with single spaces
result: " " sv except[" " vs s;enlist ""]

/ Display
show result
