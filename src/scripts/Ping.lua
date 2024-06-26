ThresholdUI.PingHistory = ThresholdUI.PingHistory or {}
ThresholdUI.MaxPings = 11 -- This needs to be the number + 1, since we always ignore the last element in the table

function ThresholdUI.EnablePing()
  ThresholdUI.Timers.PingTimer = tempTimer(10, ThresholdUI.SendPing, true)
end

function ThresholdUI.DisablePing()
  killTimer(ThresholdUI.Timers.PingTimer)
  ThresholdUI.Timers.PingTimer = nil
end

function ThresholdUI.SendPing()
  if ThresholdUI.Timers.PingTimer == nil then return end
display(ThresholdUI.PingHistory)
  local last = ThresholdUI.PingHistory[#ThresholdUI.PingHistory] or 0
  local message = "Core.Ping " .. tostring(string.format("%.0f", last * 1000))

  sendGMCP(message)

  ThresholdUI.PingHistory[#ThresholdUI.PingHistory+1] = getEpoch()
end

function ThresholdUI.ReceivePing()
  local now = getEpoch()
  local diff = now - ThresholdUI.PingHistory[#ThresholdUI.PingHistory]
  local mils = tonumber(string.format("%.4f", diff))
  ThresholdUI.PingHistory[#ThresholdUI.PingHistory] = diff
  
  if #ThresholdUI.PingHistory > ThresholdUI.MaxPings then
    table.remove(ThresholdUI.PingHistory, 1)
  end
end

function ThresholdUI.DisplayPing()
  local count = #ThresholdUI.PingHistory
  local num = count - 1
  local last = num
  local lastcount
  local out = ""
  
  local sum = 0.0
  
  if num > 0 then
    repeat
      sum = sum + ThresholdUI.PingHistory[num]
      num = num - 1
    until (num == 0)
  else
    echo("Not enough ping data to evaluate.\n")
    return
  end
  
  local avg = sum / count
  local mils = tonumber(string.format("%.4f", avg))
  local lastmils = tonumber(string.format("%.4f", ThresholdUI.PingHistory[last]))

  if last <= ThresholdUI.MaxPings - 1 then lastcount = last else lastcount = ThresholdUI.MaxPings - 1 end
  local lastpos = last - lastcount + 1
  
  out = 
    "Ping Results\n" ..
    "============\n" ..
    "Pings: " .. last .. "\n\n" ..
    "Last " .. tostring(lastcount) .. " pings:\n"

  repeat
    out = out .. " => " .. tonumber(string.format("%.4f", ThresholdUI.PingHistory[lastpos])) .. " seconds\n"
    lastpos = lastpos + 1
  until (lastpos > last)

  out = out .. "\nAverage round trip: " .. tostring(mils) .. " seconds\n"

  echo(out)
           
end

function ThresholdUI.ResetPingHistory()
  ThresholdUI.PingHistory = {}
end
