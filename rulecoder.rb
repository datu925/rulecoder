#rulecoder

#rule file looks like this:
#target fields, target phrase, outcome label, outcome column, active status

#financial data looks like this:
#some number of data columns with descriptions of the transaction, a transaction amount in final column

#for each line in data,
	#for each rule in file,
		#skip if rule is not active
		#concatenate fields that are identified by an array with column names
		#if concatenate contains the target string, put outcome label in outcome column
require 'csv'


def get_headers(file_name)

	#get headers from our file
	headers = []
	File.open(file_name) do |x|
		headers = CSV.parse(x.readline).flatten
	end

	#add the coding columns
	return headers
end

header_line = get_headers('example_data.csv')
header_line += ["Position Type", "Function Type"]

def read_line_to_array(line)

	read_line = line.inject([]) do |array, index|
		array << index[1]
	end

	read_line += ["Uncoded","Uncoded"]
	return read_line
	
end


CSV.open('new_file.csv','w') do |csv|

	csv << header_line

	#read rule line-by-line
	CSV.foreach('example_data.csv', headers:true) do |line|

		line_array = read_line_to_array(line)
		
		CSV.foreach('example_rules.csv', headers:true) do |rule|

			#skip if inactive
			next if rule['Rule Active?'] == "No"

			#determine the valid column #s to search in for the rule
			valid_columns = rule["Target Columns"].split(",")

			#test each cell in each valid column to see if it contains our target string; if so, let's make the change
			phrase_in_data = false
			valid_columns.each do |index|
				cell = line[index.to_i]
				cell = "" if cell.nil?
				if cell.downcase.include? rule["Target Phrase"].downcase
					#phrase_in_data
					index_num = header_line.index(rule["Outcome Column"])
					line_array[index_num] = rule["Outcome Label"]
					break
				end
			end

		end

		csv << line_array

	end
end