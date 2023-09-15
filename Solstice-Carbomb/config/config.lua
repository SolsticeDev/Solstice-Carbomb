--[[  
   _____       __     __  _                 ____            __                                 __ 
  / ___/____  / /____/ /_(_)_______        / __ \___ _   __/ /___  ____  ____ ___  ___  ____  / /_
  \__ \/ __ \/ / ___/ __/ / ___/ _ \______/ / / / _ \ | / / / __ \/ __ \/ __ `__ \/ _ \/ __ \/ __/
 ___/ / /_/ / (__  ) /_/ / /__/  __/_____/ /_/ /  __/ |/ / / /_/ / /_/ / / / / / /  __/ / / / /_  
/____/\____/_/____/\__/_/\___/\___/     /_____/\___/|___/_/\____/ .___/_/ /_/ /_/\___/_/ /_/\__/  
                                                               /_/                               
]]
Config = {}
Config.PoliceJob = 'police'
Config.JobDisarm = true
Config.JobInspect = true
Config.DefaultCustomSpeed = 100

Config.MinigameTime = 60

Config.ArmItem = 'ied'
Config.DisarmItem = 'disarmkit'

Config.Notifications = {
    ArmSuccess = 'You have armed the vehicle.',
    DisarmSuccess = 'You have disarmed the vehicle.',
    NoVehicle = 'No vehicle nearby.',
    NoArmedVehicle = 'No armed vehicle nearby.',
    ItemRequirementArm = 'You need the "' .. Config.ArmItem .. '" item to arm the vehicle.',
    ItemRequirementDisarm = 'You need the "' .. Config.DisarmItem .. '" item to disarm the vehicle.',
}
