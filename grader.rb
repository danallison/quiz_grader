# this code compares quiz.txt with rubric.txt
# to determine which lines are correct and which lines are incorrect
# and logs the results in results.txt

def grade
  rubric_file = File.open('rubric.txt')
  quiz_file = File.open('quiz.txt')

  rubric_lines = []
  rubric_file.lines { |line| rubric_lines << line }
  
  quiz_lines = []
  quiz_file.lines { |line| quiz_lines << line }

  correct_lines = []
  incorrect_lines = []

  quiz_lines.each do |line| 
    if rubric_lines.find { |r| r == line } == nil
      incorrect_lines << line
    else
      correct_lines << line
    end
  end
  
  number_correct = correct_lines.size
  number_incorrect = incorrect_lines.size
  date = Time.new
  
  old_results_lines = []
  File.open('results.txt').lines { |line| old_results_lines << line }
  old_results = old_results_lines.join("")
  new_results_entry = "\n --- #{date.strftime('%B %-d, %Y')} --- \n#{number_correct} correct. #{number_incorrect} incorrect.\n**INCORRECT** :\n#{incorrect_lines.join('')}\n"
  
  File.open('results.txt', 'w') {|f| f.write(new_results_entry + old_results) }
end

grade