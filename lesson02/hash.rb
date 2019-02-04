year = { "Jan" => 31, "Feb" => 28, "Mar" => 31, "Apr" => 30, "May" => 31, "Jun" => 30, "Jul" => 31, "Aug" => 31, "Sep" => 30, "Oct" => 31, "Nov" => 30, "Dec" => 31 }

year.each do |month, day|
  if day == 30
    puts month
  end
end
