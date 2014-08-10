require 'roo' 

co = Roo::Excelx.new("qdata.xlsx")
co.default_sheet = co.sheets.first

qscores = []

2.upto(9434) do |line|
  class_name = co.cell(line,'A'); 
  qscores << 
  { 
    :name => class_name,
    :course_overall => co.cell(line, 'I').to_f,
    :workload => co.cell(line, 'N').to_f,
    :difficulty => co.cell(line, 'O').to_f,
    :enrollment => co.cell(line, 'F').to_f,
    :year => co.cell(line, 'D').to_i
  } 
end

def limited_enrollment reports, enrollment 
  reports.select{|report| report[:enrollment] >= enrollment}
end

def remove_nulls reports 
  @clean_reports ||= reports.select{|report| report[:workload] >= 1 && report[:difficulty] >= 1 && report[:name].split(' ').first != "FRSEMR"}
end

def department_only reports, department 
  reports.select{|report| report[:name].split(' ').first == department}
end

def year_range reports, start, finish 
  reports.select{|report| report[:year] >= start && report[:year] <= finish}
end 

def sort_ranking reports, pairs
  reps = reports.sort do |report1, report2| 
    sum1 = 0; 
    sum2 = 0; 
    pairs.each do |key, value| 
      sum1 += report1[key] * value
      sum2 += report2[key] * value
    end
    sum1 <=> sum2
  end
  reps
end

def sort_file file_name, data 
  output = File.open(file_name, "w+")
  i = 1; 
  data.each do |course| 
    output.printf("%i %s %i: overall = %.2f, workload = %.2f, difficulty = %.2f\n", i, course[:name], course[:year], course[:course_overall], course[:workload], course[:difficulty])
    i = i +1; 
  end
  output.close
end

clean = year_range(limited_enrollment(remove_nulls(qscores), 10), 2011, 2013)



easy533 = sort_ranking(clean, {:workload => 5, :difficulty => 3, :course_overall => -3})

easyecon = department_only(easy533, "ECON")
sort_file("econ_sorted.txt", easyecon)
