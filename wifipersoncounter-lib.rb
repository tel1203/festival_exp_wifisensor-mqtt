def calc_wifipersoncounter(dir, interval)
  time_now = Time.now.to_f
  files = Dir::entries(dir)
  files_sort = files.sort
  
  file1 = files_sort[-1]
  file2 = files_sort[-2]
  
  ids = []
  ids_last = []
  [file1, file2].each do |file|
    f = open(dir + "/" + file, "r")
    while ((line = f.gets) != nil) do
      tmp = line.split(",")
      if (tmp[0].to_f > time_now-(interval*2) and 
          tmp[0].to_f < time_now-(interval)) then
        begin
          ids_last |= [tmp[1]]
        rescue
        end
      end
  
      if (tmp[0].to_f > time_now-(interval)) then 
        ids |= [tmp[1]]
      end
    end
  end
  
  current = ids.size
  coming  = (ids-ids_last).size
  left    = (ids_last-ids).size

  return ([current, coming, left])
end

