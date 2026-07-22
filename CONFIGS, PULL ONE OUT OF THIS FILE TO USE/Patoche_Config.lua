Config = {}

--Don't Touch
Config.CurrentV = "1.0 HD" --Don't Touch

--Important Configs
Config.OLDESX = false --IF you are using Weight System = false, Limit System = true
Config.ESXVersion = '1.2' --Examples (1.0, 1.1, 1.2)
Config.MenuLoc = 'right' --Where all esx mneus will shows up in this script
Config.Notifications = 'esx' --This either can be {esx, mythic, tnotify}
Config.UsingHDBlips = false --This is if you are using my free blip management script! If so it only does the prison blip!
Config.SyncInterval = 2 --How often the server updates the database for times left on players
Config.MaxPerCell = 4 --How many are allowed per cell! Would recommend leaving high
Config.MaxJail = 600 --Max amount someone can be intially jailed for

Config.ServerName = 'Test RP' --Server name to show up on 2D text! If you want it to be blank leave it blank!

Config.PoliceNotifyTime = 5 --How long for police to know that someone escaped (in mins)
Config.PoliceRoles = { --All police roles so that they have access to search and use menu
    'police'
}
Config.PoliceRanks = { --All ranks for being able to use certain things on menu
    Jailing = {
        {Job = 'police', Grade = 1}
    },
    UnJail = {
        {Job = 'police', Grade = 4}
    },
    AddTime = {
        {Job = 'police', Grade = 2}
    },
    RemoveTime = {
        {Job = 'police', Grade = 4}
    },
    Send2Solitary = {
        {Job = 'police', Grade = 3}
    },
    RemoveFromSolitary = {
        {Job = 'police', Grade = 4}
    },
    Lockdown = {
        {Job = 'police', Grade = 2}
    },
    Message = {
        {Job = 'police', Grade = 1}
    }
}

Config.DefaultSetJob = {Name = 'unemployed', Grade = 0} --This is the default job that it will set if not saved somehow in database
Config.SimpleTime = false --This is if you wan the time to just be seconds, recommend leaving this to false

--General Configs
Config.SeeDist = 5 --How close you have to be to see 3D markers
Config.TextDist = 1 --How close you have to be to see 3D text
Config.TextLift = 0.3 --How much the 3D text is lifted over marker

Config.Alarm = true --THIS IS ONLY FOR UNCLEJUST MAP! (if not using make false)

Config.JailBlip = {Spawn = true, Sprite = 238, Color = 1, Size = 0.7} --All blip related things for the Prison Blip
Config.JailLoc = vector3(686.79632568359, 133.33027648926, 80.749351501465) --Location of the prison (usually center so that it doesn read wrong for checking location)
Config.TpBack = true --If players get tp'd back when they walk out of the jail without using script breakout (suggest to keep true)
Config.MaxTpDist = 150 --How far until it will tp you back
Config.MaxSolTpDist = 5 --How far you get from solitary before it tp's you back
Config.MaxMenuDist = 2 --How far you can walk before it auto closes your esx menu

Config.RanMessage = true --If it gives random notifactions for prisoners
Config.RanMessageTime = 5 --How often it sends a message (in mins)
--LockDown Configs
Config.StartLockCount = 60 --Starting time for lockdown (in seconds)
Config.WarnLockNums = {45, 30, 15, 10, 5, 4, 3, 2, 1} --All warning notifications for time on lockdown, make sure its within the number above

Config.LockDownDist = 4 --How far you can get from cell before it tp's you back or sends you to solitary

--Police Search Configs
Config.PoliceCanSearchInv = true --If police can search the inventories

Config.SeePoliceDist = 5 --How close you have to be to see 3D markers
Config.UsePoliceDist = 1 --How close you have to be to see 3D text
Config.PMarkNum = 22 --Marker Number
Config.PMarkColor = {r = 235, g = 116, b = 52} --Marker Colors
Config.PMarkSize = {x = 0.5, y = 0.5, z = 0.3} --Marker Size

--Usable Item Configs
Config.ShankWeapon = 'weapon_knife' --Weapon name for shank (don't change)
Config.ShankItem = true --If the shank/weapon is used in hotbar inventory
Config.ShankAllowed = true --If you can use the shank

Config.BoozeAllowed = true --If you can use the booze item
Config.BoozeEffect = true --If taking booze has an effect
Config.BoozeGive = 80000 --How much thirst gives for drinking booze (out of 1,000,000)
Config.BoozeProp = nil --Prop to be spawned while using item (leave nil if you want default cup)
Config.BoozeEffectTime = 30 --How long the effect lasts

Config.PunchAllowed = true --If you can use the punch item
Config.PunchGive = 100000 --How much thirst gives for drinking punch (out of 1,000,000)
Config.PunchProp = nil --Prop to be spawned while using item (leave nil if you want default cup)

--Entering Guide
Config.HaveGuide = true --If there is a guide of the prison when they are first sent
Config.TimePer = 5 --How long per cam for guide (in seconds)

Config.PrisonCam = vector3(759.32348632812, 122.22653198242, 119.80345153809) --Position of the camera view 
Config.PrisonCamRot = {x = -35.0, y = 0.0, z = 65.0} --Rotation of the camera view 

Config.JobCam = vector3(685.27734375, 163.00776672363, 80.954165649414) --Position of the camera view 
Config.JobCamRot = {x = 0.0, y = 0.0, z = -20.0} --Rotation of the camera view 

Config.SolCam = vector3(1653.9808349609, 2567.3181152344, 47.35973739624) --Position of the camera view (Only Will Show If Solitary Is On)
Config.SolCamRot = {x = -25.0, y = 0.0, z = 45.0} --Rotation of the camera view (Only Will Show If Solitary Is On)

Config.WorkOutCam = vector3(682.57763671875, 90.369781494141, 82.967445373535) --Position of the camera view (Only Will Show If WorkOut Is On)
Config.WorkOutCamRot = {x = -10.0, y = 0.0, z = -35.0} --Rotation of the camera view (Only Will Show If WorkOut Is On)

Config.ShowerCam = vector3(654.9091796875, 89.411773681641, 84.58113861084) --Position of the camera view (Only Will Show If Shower Is On)
Config.ShowerCamRot = {x = 0.0, y = 0.0, z = 35.0} --Rotation of the camera view (Only Will Show If Shower Is On)

Config.FoodCam = vector3(661.99682617188, 133.59175109863, 81.392356872559) --Position of the camera view 
Config.FoodCamRot = {x = 0.0, y = 0.0, z = 160.0} --Rotation of the camera view 

Config.HospitalCam = vector3(727.20184326172, 157.00975036621, 81.707374572754) --Position of the camera view (Only Will Show If Hospital Is On)
Config.HospitalCamRot = {x = -25.0, y = 0.0, z = 45.0} --Rotation of the camera view (Only Will Show If Hospital Is On)

Config.ItemCam = vector3(726.16644287109, 139.72174072266, 82.148399353027) --Position of the camera view (Only Will Show If There Is Items To Keep)
Config.ItemCamRot = {x = -10.0, y = 0.0, z = 170.0} --Rotation of the camera view (Only Will Show If There Is Items To Keep)

--Entering Prison Cutscene Configs (Don't touch this unless you know what you're doing!)
Config.GuardPed = 'csb_cop' --The ped that carries you in
Config.GuardSpawn = {Loc = vector3(405.60272216797, -1000.9990844727, -99.004028320312), Heading = 2.9} --Where the guard spawns
Config.HandCuffLoc = vector3(405.94161987305, -999.58270263672, -99.004028320312) --Where it spawns you
Config.ClothesLoc = {Loc = vector3(402.74792480469, -1000.0263671875, -99.004043579102), Heading = 183.02} --Where the gaurd carries you to
Config.ClothesProp = 'prop_cs_t_shirt_pile' --Prop that is in hands and on table
Config.ClothPropLoc = {Loc = vector3(402.36535644531, -1001.2421264648, -98.086471557617), Heading = 356.48} --Location of the prop spawn
Config.ComputerLoc = {Loc = vector3(401.48217773438, -1001.8327026367, -99.004035949707), Heading = 1.97} --Where the gaurd looks at his computer
Config.PointLoc = {Loc = vector3(402.08111572266, -1001.8852539062, -99.004035949707), Heading = 357.9} --Where the gaurd comes and points
Config.GrabLoc = {Loc = vector3(403.19427490234, -997.42065429688, -99.001533508301), Heading = 12.43} --Where the gaurd goes to grab the player after
Config.GrabTurnHead = 258.46 --Heading which faces the exit
Config.PedGrabHeading = 24.44 --Which heading you face when grabbed
Config.StopnLook = {Loc = vector3(403.37203979492, -1002.0308837891, -99.004119873047), Heading = 359.19} --Stop and go point for gaurd so they don't have issues
Config.StopnLook2 = 85.28 --Heading for second stop n go
Config.StopnTurn = {Loc = vector3(405.93243408203, -997.45745849609, -99.004119873047), Heading = 97.76} --Another stop n go poi
Config.Undressed = { --Undressed Player Outfit
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1']  = 15, ['torso_2']  = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms']     = 15,   ['pants_1']  = 21,
        ['pants_2']  = 0,   ['shoes_1']  = 34,
        ['shoes_2']  = 0,   ['mask_1']   = 0,
        ['mask_2']   = 0,   ['bproof_1'] = 0,
        ['bproof_2'] = 0,   ['chain_1']  = 0,
        ['chain_2']  = 0,   ['helmet_1'] = -1,
        ['helmet_2'] = 0,   ['glasses_1'] = 0,
        ['glasses_2'] = 0
    },
    female = {
        ['tshirt_1'] = 15,   ['tshirt_2'] = 0,
        ['torso_1']  = 15,  ['torso_2']  = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms']     = 15,   ['pants_1']  = 15,
        ['pants_2']  = 0,  ['shoes_1']  = 35,
        ['shoes_2']  = 0,   ['mask_1']   = 0,
        ['mask_2']   = 0,   ['bproof_1'] = 0,
        ['bproof_2'] = 0,   ['chain_1']  = 0,
        ['chain_2']  = 0,   ['helmet_1'] = -1,
        ['helmet_2'] = 0,   ['glasses_1'] = 0,
        ['glasses_2'] = 0
    }
}
Config.EnterLoc = vector3(402.86895751953, -996.55413818359, -99.00025177002) --Sign Location
Config.EnterHeadings = {Front = 178.32, Side = 264.63} --Both Sign Headings
Config.WalkLoc = vector3(406.04782104492, -997.09332275391, -99.004028320312) --Final walk to desination in the hallway

Config.Cam = vector3(402.91775512695, -1002.5331420898, -99.004035949707) --Position of the camera view
Config.CamRot = {x = 0.0, y = 0.0, z = 0.0} --Rotation of the camera view

Config.DontTakeGunUponEntry = { --All weapons that arn't taken upon entering jail

}
Config.DontTakeItemsUponEntry = { --These are all the items that don't get taken upon entering the jail (whitelisting items)
    'apple'
}
Config.DontGiveBackItems = { --These are all the items that it won't give back upon grabbing items when leaving (black listing items)
    'drugs'
}

Config.AlertServerUponJail = true --Whether a chat message is sent when jailed

--Leave Configs
Config.LeaveLoc = {Loc = vector3(726.70935058594, 137.86929321289, 80.754257202148), Heading = 236.15} --Leave spawn location with heading

Config.LMarkNum = 22 --Marker Num for picking up items
Config.LMarkColor = {r = 235, g = 116, b = 52} --Marker Color for picking up items
Config.LMarkSize = {x = 0.5, y = 0.5, z = 0.3} --Marker Size for picking up items
Config.ItemLoc = {Loc = vector3(727.37280273438, 133.31517028809, 80.956428527832), Heading = 326.26} --Location on where to pick up items
Config.ItemBlip = {Spawn = true, Sprite = 475, Color = 1, Size = 0.7} --Blip for picking up items
Config.ShowItemDist = 7 --Showing the 3d marker distance 
Config.ItemTextDist = 1 --Distance for showing 3dtext above marker
Config.RetreiveTime = 5 --How long it takes to grab items back (in seconds)

--Food Configs
Config.GetFoodLoc = {Loc = vector3(658.65368652344, 128.95074462891, 80.734649658203), Heading = 157.81} --Where you grab food in prison
Config.FoodBlip = {Spawn = true, Sprite = 272, Color = 2, Size = 0.7} --Blip on map for grabbing food in prison
Config.GrabFoodTime = 5 --How long it takes to grab the food (in seconds)
Config.EatTime = 7 --How long it takes to eat the food (in seconds)

Config.FoodAmt = 100000 --How much Hunger is added to esx_status (out of 1,000,000)
Config.DrinkAmt = 100000 --How much Thirst is added to esx_status (out of 1,000,000)

Config.FoMarkNum = 29 --Marker Num for food
Config.FoMarkColor = {r = 46, g = 166, b = 25} --Marker Color for food
Config.FoMarkSize = {x = 0.5, y = 0.5, z = 0.5} --Marker Size for food

--Break Configs
Config.BrMarkNum = 32 --Marker Num for breaking out in cell location
Config.BrMarkColor = {r = 227, g = 122, b = 16} --Marker Color for breaking out in cell location
Config.BrMarkSize = {x = 0.5, y = 0.5, z = 0.5} --Marker Size for breaking out in cell location

--Inventory Configs
Config.InvBlip = {Spawn = true, Sprite = 587, Color = 29, Size = 0.7} --Blip for the under the bed inventory

Config.OpenCloseTime = 5 --How long it takes to open or close the inventory (in seconds)
Config.ChMarkNum = 21 --Marker Num for bed inventory
Config.ChMarkColor = {r = 16, g = 83, b = 227} --Marker Color for bed inventory
Config.ChMarkSize = {x = 0.5, y = 0.5, z = 0.3} --Marker Size for bed inventory


--Crafting Configs
Config.Crafts = { --All things that can be crafted with Old Man
    [1] = {
        Name = "Shank", --Name in menu of item
        Time = 20, --How long it takes to craft
        MakeItem = 'HD_Shank', --The item name in DB of what is given
        Descripe = "You can use this for self defense!", --The description of this item
        Needed = { --These are all the needed items to make the item above
            [1] = {
                Name = "Broken Spoon", --Name of needed item
                Amount = 1, --How many needed
                Item = 'HD_jspoon' --Name in db of item thats needed
            },
            [2] = {
                Name = "Change",
                Amount = 2,
                Item = 'HD_sChange'
            }
        }
    },
    [2] = {
        Name = "Broken Spoon",
        Time = 8,
        MakeItem = 'HD_jspoon',
        Descripe = "You can use this for breaking out or for more crafting!",
        Needed = {
            [1] = {
                Name = "Spoon",
                Amount = 1,
                Item = 'HD_spoon'
            }
        }
    },
    [3] = {
        Name = "Broken Spoon With Wet Cloth",
        Time = 5,
        MakeItem = 'HD_bCloth',
        Descripe = "You can use this for breaking out!",
        Needed = {
            [1] = {
                Name = "Broken Spoon",
                Amount = 1,
                Item = 'HD_jspoon'
            },
            [2] = {
                Name = "Wet Cloth",
                Amount = 1,
                Item = 'HD_wCloth'
            }
        }
    },
    [4] = {
        Name = "Wet Cloth",
        Time = 10,
        MakeItem = 'HD_wCloth',
        Descripe = "You can use this for more crafting!",
        Needed = {
            [1] = {
                Name = "Cleaner",
                Amount = 1,
                Item = 'HD_cleaner'
            },
            [2] = {
                Name = "Cloth",
                Amount = 1,
                Item = 'HD_cloth'
            }
        }
    },
    [5] = {
        Name = "File",
        Time = 20,
        MakeItem = 'HD_file',
        Descripe = "You can use this for breaking out or more crafting!",
        Needed = {
            [1] = {
                Name = "Rock",
                Amount = 2,
                Item = 'HD_rock'
            },
            [2] = {
                Name = "Broken Ladle",
                Amount = 1,
                Item = 'HD_bLadle'
            }
        }
    },
    [6] = {
        Name = "Broken Ladle",
        Time = 5,
        MakeItem = 'HD_bLadle',
        Descripe = "You can use this for more crafting!",
        Needed = {
            [1] = {
                Name = "Ladle",
                Amount = 1,
                Item = 'HD_ladle'
            }
        }
    },
    [7] = {
        Name = "Sharp Metal",
        Time = 20,
        MakeItem = 'HD_sMetal',
        Descripe = "You can use this for breaking out!",
        Needed = {
            [1] = {
                Name = "Metal",
                Amount = 1,
                Item = 'HD_metal'
            },
            [2] = {
                Name = "Rock",
                Amount = 2,
                Item = 'HD_rock'
            },
            [3] = {
                Name = "File",
                Amount = 1,
                Item = 'HD_file'
            }
        }
    },
    [8] = {
        Name = "Acid",
        Time = 30,
        MakeItem = 'HD_acid',
        Descripe = "You can use this for breaking out!",
        Needed = {
            [1] = {
                Name = "Bottle",
                Amount = 1,
                Item = 'HD_bottle'
            },
            [2] = {
                Name = "Grease",
                Amount = 3,
                Item = 'HD_grease'
            },
            [3] = {
                Name = "Dirty Liquid",
                Amount = 1,
                Item = 'HD_dLiquid'
            },
            [4] = {
                Name = "Cleaner",
                Amount = 1,
                Item = 'HD_cleaner'
            },
            [5] = {
                Name = "Spoon",
                Amount = 1,
                Item = 'HD_spoon'
            }
        }
    },
    [9] = {
        Name = "Mini Hammer",
        Time = 25,
        MakeItem = 'HD_miniH',
        Descripe = "You can use this for breaking out!",
        Needed = {
            [1] = {
                Name = "Metal",
                Amount = 1,
                Item = 'HD_metal'
            },
            [2] = {
                Name = "Rock",
                Amount = 1,
                Item = 'HD_rock'
            },
            [3] = {
                Name = "Ladle",
                Amount = 1,
                Item = 'HD_ladle'
            },
            [4] = {
                Name = "Cloth",
                Amount = 1,
                Item = 'HD_cloth'
            }
        }
    },
    [10] = {
        Name = "Prison Punch",
        Time = 10,
        MakeItem = 'HD_pPunch',
        Descripe = "You can use this to tend to your thirst!",
        Needed = {
            [1] = {
                Name = "Dirty Liquid",
                Amount = 1,
                Item = 'HD_dLiquid'
            },
            [2] = {
                Name = "Flavor Packet",
                Amount = 3,
                Item = 'HD_fPacket'
            },
            [3] = {
                Name = "Bottle",
                Amount = 1,
                Item = 'HD_bottle'
            }
        }
    },
    [11] = {
        Name = "Immersion Heater",
        Time = 25,
        MakeItem = 'HD_iHeat',
        Descripe = "You can use this to distil alcohol!",
        Needed = {
            [1] = {
                Name = "Plug",
                Amount = 1,
                Item = 'HD_plug'
            },
            [2] = {
                Name = "Spare Change",
                Amount = 2,
                Item = 'HD_sChange'
            }
        }
    },
    [12] = {
        Name = "Booze",
        Time = 15,
        MakeItem = 'HD_booze',
        Descripe = "You can use this to get drunk!",
        Needed = {
            [1] = {
                Name = "Immersion Heater",
                Amount = 1,
                Item = 'HD_iHeat'
            },
            [2] = {
                Name = "Prison Punch",
                Amount = 1,
                Item = 'HD_pPunch'
            }
        }
    }
}

--Information Configs (Old Man Configs)
Config.InfoPed = 'csb_rashcosvki' --Model of the Old Man ped
Config.InfoPedChangeTime = 3 -- How long until the old man changes locations (in mins)
Config.InfoPedLoc = { --All the locations that the ped could be
    [1] = {Loc = vector3(704.61486816406, 160.01112365723, 80.754264831543), Heading = 125.56},
    [2] = {Loc = vector3(665.98760986328, 149.58874511719, 80.754264831543), Heading = 341.52},
    [3] = {Loc = vector3(702.35675048828, 92.121597290039, 80.754264831543), Heading = 56.92},
    [4] = {Loc = vector3(652.06323242188, 118.06665039062, 80.754188537598), Heading = 204.22}
}
Config.InfoPedBlip = {Spawn = true, Sprite = 66, Color = 5, Size = 0.7} --All blip configs for the old man

Config.IMarkNum = 27 --Old man 3d marker num
Config.IMarkColor = {r = 227, g = 223, b = 16} --Old man 3d marker color
Config.IMarkSize = {x = 1.0, y = 1.0, z = 0.5} --Old man 3d marker size

--Job Manager Configs
Config.JobManLoc = {Loc = vector3(686.53479003906, 167.36427307129, 80.754180908203), Heading = 163.58} --Job manager ped location
Config.JobManBlip = {Spawn = true, Sprite = 468, Color = 50, Size = 0.7} --Job manager blip
Config.JobManPed = 's_m_m_prisguard_01' --Job manager ped

Config.JMMarkNum = 27 --Job manager 3d marker num
Config.JMMarkColor = {r = 255, g = 0, b = 255} --Job manager 3d marker color
Config.JMMarkSize = {x = 1.0, y = 1.0, z = 0.5} --Job manager 3d marker size

Config.SeeTaskMark = 5 --How close you have to be to see the 3d marker
Config.SeeTaskText = 0.8 --How close you have to be to do the task
Config.JobOptions = {
    [1] = {
        Name = "Shower Cleaner",--Name of the job
        TimeRemove = 20, --How much time is removed for completing all the tasks (in seconds)
        StealChance = 3, --How likely it is to steal an item after completing task (3 = 30%, 5 = 50%, out of 100)
        StealItems = { --Items that can be stealing
            [1] = {Name = "Cleaner", Item = 'HD_cleaner', Chance = 5}, -- (Name = Name of the item, Item = DB Name of item, Chance = the chance out of 10 or in relation to percentage, 5 = 50%)
            [2] = {Name = "Dirty Liquid", Item = 'HD_dLiquid', Chance = 5} -- (Name = Name of the item, Item = DB Name of item, Chance = the chance out of 10 or in relation to percentage, 5 = 50%)
        },
        Tasks = { --All tasks in the job
            [1] = {
                TaskName = "Grab Cleaner", --Name of the task
                TaskLoc = {Loc = vector3(739.66314697266, 151.82011413574, 80.71802520752), Heading = 214.03}, --Location of the task
                Anim = {Dict = 'anim@amb@business@coc@coc_unpack_cut_left@', AnimName = 'coke_cut_v5_coccutter'}, --Anim that is played at the task (Dict = Dictionary Name, AnimName = Animation)
                Time = 7, --How long the animation is for (in seconds)
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7}, --All the blip configs for this task
                MarkNum = 20, --Marker Num for this task
                MarkColor = {r = 235, g = 116, b = 52}, --Marker Color for this task
                MarkSize = {x = 0.5, y = 0.5, z = 0.3}, --Marker Size for this task
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}, --If an item is attached for the animation (Attach = If it spawns something, Prop = Prop name, Offests = All offsets)
                CarryItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}} --If an item is attached for walk in between tasks (Attach = If it spawns something, Prop = Prop name, Offests = All offsets)
            },
            [2] = {
                TaskName = "Clean Wall", --Name of the task
                TaskLoc = {Loc = vector3(651.00054931641, 97.861526489258, 84.081787109375), Heading = 265.02}, --Location of the task
                Anim = {Dict = 'amb@world_human_maid_clean@', AnimName = 'base'}, --Anim that is played at the task (Dict = Dictionary Name, AnimName = Animation)
                Time = 10, --How long the animation is for (in seconds)
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7}, --All the blip configs for this task
                MarkNum = 20, --Marker Num for this task
                MarkColor = {r = 235, g = 116, b = 52}, --Marker Color for this task
                MarkSize = {x = 0.5, y = 0.5, z = 0.3}, --Marker Size for this task
                AttachItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}, --If an item is attached for the animation (Attach = If it spawns something, Prop = Prop name, Offests = All offsets)
                CarryItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}} --If an item is attached for walk in between tasks (Attach = If it spawns something, Prop = Prop name, Offests = All offsets)
            },
            [3] = {
                TaskName = "Clean Wall", --Name of the task
                TaskLoc = {Loc = vector3(648.68731689453, 97.876739501953, 84.081481933594), Heading = 269.18}, --Location of the task
                Anim = {Dict = 'amb@world_human_maid_clean@', AnimName = 'base'}, --Anim that is played at the task (Dict = Dictionary Name, AnimName = Animation)
                Time = 10, --How long the animation is for (in seconds)
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7}, --All the blip configs for this task
                MarkNum = 20, --Marker Num for this task
                MarkColor = {r = 235, g = 116, b = 52}, --Marker Color for this task
                MarkSize = {x = 0.5, y = 0.5, z = 0.3}, --Marker Size for this task
                AttachItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}, --If an item is attached for the animation (Attach = If it spawns something, Prop = Prop name, Offests = All offsets)
                CarryItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}} --If an item is attached for walk in between tasks (Attach = If it spawns something, Prop = Prop name, Offests = All offsets)
            },
            [4] = {
                TaskName = "Clean Wall", --Name of the task
                TaskLoc = {Loc = vector3(646.40289306641, 97.883323669434, 84.08162689209), Heading = 262.73}, --Location of the task
                Anim = {Dict = 'amb@world_human_maid_clean@', AnimName = 'base'}, --Anim that is played at the task (Dict = Dictionary Name, AnimName = Animation)
                Time = 10, --How long the animation is for (in seconds)
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7}, --All the blip configs for this task
                MarkNum = 20, --Marker Num for this task
                MarkColor = {r = 235, g = 116, b = 52}, --Marker Color for this task
                MarkSize = {x = 0.5, y = 0.5, z = 0.3}, --Marker Size for this task
                AttachItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}, --If an item is attached for the animation (Attach = If it spawns something, Prop = Prop name, Offests = All offsets)
                CarryItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}} --If an item is attached for walk in between tasks (Attach = If it spawns something, Prop = Prop name, Offests = All offsets)
            },
            [5] = {
                TaskName = "Clean Wall", --Name of the task
                TaskLoc = {Loc = vector3(644.64508056641, 93.355339050293, 84.082023620605), Heading = 247.1}, --Location of the task
                Anim = {Dict = 'amb@world_human_maid_clean@', AnimName = 'base'}, --Anim that is played at the task (Dict = Dictionary Name, AnimName = Animation)
                Time = 10, --How long the animation is for (in seconds)
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7}, --All the blip configs for this task
                MarkNum = 20, --Marker Num for this task
                MarkColor = {r = 235, g = 116, b = 52}, --Marker Color for this task
                MarkSize = {x = 0.5, y = 0.5, z = 0.3}, --Marker Size for this task
                AttachItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}, --If an item is attached for the animation (Attach = If it spawns something, Prop = Prop name, Offests = All offsets)
                CarryItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}} --If an item is attached for walk in between tasks (Attach = If it spawns something, Prop = Prop name, Offests = All offsets)
            },
            [6] = {
                TaskName = "Clean Wall", --Name of the task
                TaskLoc = {Loc = vector3(646.47723388672, 92.524032592773, 84.081924438477), Heading = 246.11}, --Location of the task
                Anim = {Dict = 'amb@world_human_maid_clean@', AnimName = 'base'}, --Anim that is played at the task (Dict = Dictionary Name, AnimName = Animation)
                Time = 10, --How long the animation is for (in seconds)
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7}, --All the blip configs for this task
                MarkNum = 20, --Marker Num for this task
                MarkColor = {r = 235, g = 116, b = 52}, --Marker Color for this task
                MarkSize = {x = 0.5, y = 0.5, z = 0.3}, --Marker Size for this task
                AttachItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}, --If an item is attached for the animation (Attach = If it spawns something, Prop = Prop name, Offests = All offsets)
                CarryItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}} --If an item is attached for walk in between tasks (Attach = If it spawns something, Prop = Prop name, Offests = All offsets)
            },
            [7] = {
                TaskName = "Clean Wall", --Name of the task
                TaskLoc = {Loc = vector3(648.68927001953, 91.499954223633, 84.081237792969), Heading = 246.36}, --Location of the task
                Anim = {Dict = 'amb@world_human_maid_clean@', AnimName = 'base'}, --Anim that is played at the task (Dict = Dictionary Name, AnimName = Animation)
                Time = 10, --How long the animation is for (in seconds)
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7}, --All the blip configs for this task
                MarkNum = 20, --Marker Num for this task
                MarkColor = {r = 235, g = 116, b = 52}, --Marker Color for this task
                MarkSize = {x = 0.5, y = 0.5, z = 0.3}, --Marker Size for this task
                AttachItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}, --If an item is attached for the animation (Attach = If it spawns something, Prop = Prop name, Offests = All offsets)
                CarryItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}} --If an item is attached for walk in between tasks (Attach = If it spawns something, Prop = Prop name, Offests = All offsets)
            },
            [8] = {
                TaskName = "Clean Wall", --Name of the task
                TaskLoc = {Loc = vector3(650.96887207031, 90.560958862305, 84.08113861084), Heading = 240.97}, --Location of the task
                Anim = {Dict = 'amb@world_human_maid_clean@', AnimName = 'base'}, --Anim that is played at the task (Dict = Dictionary Name, AnimName = Animation)
                Time = 10, --How long the animation is for (in seconds)
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7}, --All the blip configs for this task
                MarkNum = 20, --Marker Num for this task
                MarkColor = {r = 235, g = 116, b = 52}, --Marker Color for this task
                MarkSize = {x = 0.5, y = 0.5, z = 0.3}, --Marker Size for this task
                AttachItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}, --If an item is attached for the animation (Attach = If it spawns something, Prop = Prop name, Offests = All offsets)
                CarryItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}} --If an item is attached for walk in between tasks (Attach = If it spawns something, Prop = Prop name, Offests = All offsets)
            },
            [9] = {
                TaskName = "Return Cleaner", --Name of the task
                TaskLoc = {Loc = vector3(739.66314697266, 151.82011413574, 80.71802520752), Heading = 214.03}, --Location of the task
                Anim = {Dict = 'anim@amb@business@coc@coc_unpack_cut_left@', AnimName = 'coke_cut_v5_coccutter'}, --Anim that is played at the task (Dict = Dictionary Name, AnimName = Animation)
                Time = 7, --How long the animation is for (in seconds)
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7}, --All the blip configs for this task
                MarkNum = 20, --Marker Num for this task
                MarkColor = {r = 235, g = 116, b = 52}, --Marker Color for this task
                MarkSize = {x = 0.5, y = 0.5, z = 0.3}, --Marker Size for this task
                AttachItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}, --If an item is attached for the animation (Attach = If it spawns something, Prop = Prop name, Offests = All offsets)
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}} --If an item is attached for walk in between tasks (Attach = If it spawns something, Prop = Prop name, Offests = All offsets)
            }
        },
    },
    [2] = {
        Name = "Cleaning Clothes",
        TimeRemove = 25,
        StealChance = 3,
        StealItems = {
            [1] = {Name = "Cleaner", Item = 'HD_cleaner', Chance = 5},
            [2] = {Name = "Cloth", Item = 'HD_cloth', Chance = 3},
            [3] = {Name = "Dirty Liquid", Item = 'HD_dLiquid', Chance = 7}
        },
        Tasks = {
            [1] = {
                TaskName = "Grab Dirty Clothes",
                TaskLoc = {Loc = vector3(654.07763671875, 96.949546813965, 80.717628479004), Heading = 185.85},
                Anim = {Dict = 'anim@amb@business@coc@coc_unpack_cut_left@', AnimName = 'coke_cut_v5_coccutter'},
                Time = 15,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 15,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_ld_tshirt_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [2] = {
                TaskName = "Put Clothes in Washer",
                TaskLoc = {Loc = vector3(652.69470214844, 97.084503173828, 80.717628479004), Heading = 177.83},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_ld_tshirt_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [3] = {
                TaskName = "Put Clothes in Washer",
                TaskLoc = {Loc = vector3(648.57989501953, 97.08610534668, 80.717628479004), Heading = 177.18},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_ld_tshirt_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [4] = {
                TaskName = "Put Clothes in Washer",
                TaskLoc = {Loc = vector3(647.28393554688, 97.107177734375, 80.717628479004), Heading = 180.92},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [5] = {
                TaskName = "Switch To Dry",
                TaskLoc = {Loc = vector3(652.69470214844, 97.084503173828, 80.717628479004), Heading = 177.83},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = true, Prop = 'prop_ld_tshirt_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [6] = {
                TaskName = "Switch To Dry",
                TaskLoc = {Loc = vector3(648.57989501953, 97.08610534668, 80.717628479004), Heading = 177.18},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = true, Prop = 'prop_ld_tshirt_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [7] = {
                TaskName = "Switch To Dry",
                TaskLoc = {Loc = vector3(647.28393554688, 97.107177734375, 80.717628479004), Heading = 180.92},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = true, Prop = 'prop_ld_tshirt_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [8] = {
                TaskName = "Grab Dry Clothes",
                TaskLoc = {Loc = vector3(652.69470214844, 97.084503173828, 80.717628479004), Heading = 177.83},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_ld_tshirt_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [9] = {
                TaskName = "Grab Dry Clothes",
                TaskLoc = {Loc = vector3(648.57989501953, 97.08610534668, 80.717628479004), Heading = 177.18},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_ld_tshirt_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [10] = {
                TaskName = "Grab Dry Clothes",
                TaskLoc = {Loc = vector3(647.28393554688, 97.107177734375, 80.717628479004), Heading = 180.92},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_ld_tshirt_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [11] = {
                TaskName = "Put Clothes On Rack",
                TaskLoc = {Loc = vector3(648.78045654297, 98.411643981934, 80.717613220215), Heading = 358.89},
                Anim = {Dict = 'anim@amb@business@coc@coc_unpack_cut_left@', AnimName = 'coke_cut_v5_coccutter'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = true, Prop = 'prop_ld_tshirt_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second = 0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            }
        }
    },
    [3] = {
        Name = "Laundry Runner",
        TimeRemove = 10,
        StealChance = 2,
        StealItems = {
            [1] = {Name = "Bottle", Item = 'HD_bottle', Chance = 1},
            [2] = {Name = "Cloth", Item = 'HD_cloth', Chance = 6},
        },
        Tasks = {
            [1] = {
                TaskName = "Grab Dirty Clothes",
                TaskLoc = {Loc = vector3(740.79272460938, 148.14070129395, 80.717895507812), Heading = 286.52},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 2, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 235, b = 82},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_ld_tshirt_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [2] = {
                TaskName = "Drop Off Dirty Clothes",
                TaskLoc = {Loc = vector3(654.00915527344, 96.996238708496, 80.717643737793), Heading = 189.64},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 2, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [3] = {
                TaskName = "Grab Dirty Clothes",
                TaskLoc = {Loc = vector3(740.19213867188, 149.70001220703, 80.717887878418), Heading = 306.28},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 2, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 235, b = 82},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_ld_tshirt_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [4] = {
                TaskName = "Drop Off Dirty Clothes",
                TaskLoc = {Loc = vector3(654.00915527344, 96.996238708496, 80.717643737793), Heading = 189.64},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 2, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [5] = {
                TaskName = "Grab Dirty Clothes",
                TaskLoc = {Loc = vector3(643.67730712891, 94.118965148926, 84.081161499023), Heading = 79.71},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 2, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 235, b = 82},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_ld_tshirt_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [6] = {
                TaskName = "Drop Off Dirty Clothes",
                TaskLoc = {Loc = vector3(654.00915527344, 96.996238708496, 80.717643737793), Heading = 189.64},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 2, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [7] = {
                TaskName = "Grab Dirty Clothes",
                TaskLoc = {Loc = vector3(653.38745117188, 98.246078491211, 80.717628479004), Heading = 54.76},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 2, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 235, b = 82},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_ld_tshirt_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [8] = {
                TaskName = "Drop Off Dirty Clothes",
                TaskLoc = {Loc = vector3(654.00915527344, 96.996238708496, 80.717643737793), Heading = 189.64},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 2, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [9] = {
                TaskName = "Grab Dirty Clothes",
                TaskLoc = {Loc = vector3(651.1513671875, 97.228034973145, 80.722496032715), Heading = 115.74},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 2, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 235, b = 82},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_ld_tshirt_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [10] = {
                TaskName = "Drop Off Dirty Clothes",
                TaskLoc = {Loc = vector3(654.00915527344, 96.996238708496, 80.717643737793), Heading = 189.64},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 2, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            }
        }
    },
    [4] = {
        Name = "Cafe Cleaner",
        TimeRemove = 25,
        StealChance = 4,
        StealItems = {
            [1] = {Name = "Bottle", Item = 'HD_bottle', Chance = 2},
            [2] = {Name = "Grease", Item = 'HD_grease', Chance = 5},
            [3] = {Name = "Dirty Liquid", Item = 'HD_dLiquid', Chance = 5},
            [4] = {Name = "Spoon", Item = 'HD_spoon', Chance = 8},
            [5] = {Name = "Ladle", Item = 'HD_ladle', Chance = 7},
            [6] = {Name = "Flavor Packet", Item = 'HD_fPacket', Chance = 10}
        },
        Tasks = {
            [1] = {
                TaskName = "Grab Trash",
                TaskLoc = {Loc = vector3(664.3394165039, 135.98034667969, 80.734664916992), Heading = 349.65},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 229, g = 235, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [2] = {
                TaskName = "Throw Away Trash",
                TaskLoc = {Loc = vector3(667.93383789062, 136.203125, 80.734664916992), Heading = 288.59},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 229, g = 235, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [3] = {
                TaskName = "Grab Trash",
                TaskLoc = {Loc = vector3(664.33941650391, 135.98034667969, 80.734664916992), Heading = 349.65},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 229, g = 235, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [4] = {
                TaskName = "Throw Away Trash",
                TaskLoc = {Loc = vector3(667.93383789062, 136.203125, 80.734664916992), Heading = 288.59},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 229, g = 235, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [5] = {
                TaskName = "Grab Trash",
                TaskLoc = {Loc = vector3(665.02331542969, 143.75700378418, 80.734657287598), Heading = 3.67},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 229, g = 235, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [6] = {
                TaskName = "Throw Away Trash",
                TaskLoc = {Loc = vector3(667.93383789062, 136.203125, 80.734664916992), Heading = 288.59},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 229, g = 235, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [7] = {
                TaskName = "Grab Trash",
                TaskLoc = {Loc = vector3(661.34936523438, 128.08197021484, 80.734657287598), Heading = 156.62},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 229, g = 235, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [8] = {
                TaskName = "Throw Away Trash",
                TaskLoc = {Loc = vector3(667.93383789062, 136.203125, 80.734664916992), Heading = 288.59},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 229, g = 235, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            }
        }
    },
    [5] = {
        Name = "Trash Cleaner",
        TimeRemove = 25,
        StealChance = 3,
        StealItems = {
            [1] = {Name = "Bottle", Item = 'HD_bottle', Chance = 2},
            [2] = {Name = "Rock", Item = 'HD_rock', Chance = 5},
            [3] = {Name = "Broken Ladle", Item = 'HD_bLadle', Chance = 3},
            [4] = {Name = "Metal", Item = 'HD_metal', Chance = 4},
            [5] = {Name = "Broken Spoon", Item = 'HD_jspoon', Chance = 6},
            [6] = {Name = "Spare Change", Item = 'HD_sChange', Chance = 6},
            [7] = {Name = "Plug", Item = 'HD_plug', Chance = 4}
        },
        Tasks = {
            [1] = {
                TaskName = "Grab Trash",
                TaskLoc = {Loc = vector3(667.50207519531, 135.17387390137, 80.734657287598), Heading = 259.91},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'hei_prop_heist_binbag', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [2] = {
                TaskName = "Drop Trash",
                TaskLoc = {Loc = vector3(670.46398925781, 149.27941894531, 80.75415802002), Heading = 160.12},
                Anim = {Dict = 'amb@prop_human_bum_bin@base', AnimName = 'base'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [3] = {
                TaskName = "Grab Trash",
                TaskLoc = {Loc = vector3(664.99243164062, 150.74179077148, 80.75415802002), Heading = 97.62},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'hei_prop_heist_binbag', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [4] = {
                TaskName = "Drop Trash",
                TaskLoc = {Loc = vector3(670.46398925781, 149.27941894531, 80.75415802002), Heading = 160.12},
                Anim = {Dict = 'amb@prop_human_bum_bin@base', AnimName = 'base'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [5] = {
                TaskName = "Grab Trash",
                TaskLoc = {Loc = vector3(668.03747558594, 136.68270874023, 80.734657287598), Heading = 243.84},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'hei_prop_heist_binbag', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [6] = {
                TaskName = "Drop Trash",
                TaskLoc = {Loc = vector3(670.46398925781, 149.27941894531, 80.75415802002), Heading = 160.12},
                Anim = {Dict = 'amb@prop_human_bum_bin@base', AnimName = 'base'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [7] = {
                TaskName = "Grab Trash",
                TaskLoc = {Loc = vector3(664.15270996094, 147.15267944336, 80.734649658203), Heading = 337.47},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'hei_prop_heist_binbag', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [8] = {
                TaskName = "Drop Trash",
                TaskLoc = {Loc = vector3(670.46398925781, 149.27941894531, 80.75415802002), Heading = 160.12},
                Anim = {Dict = 'amb@prop_human_bum_bin@base', AnimName = 'base'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            }
        }
    },
    [6] = {
        Name = "Scraper",
        TimeRemove = 25,
        StealChance = 3,
        StealItems = {
            [1] = {Name = "Rock", Item = 'HD_rock', Chance = 5},
            [2] = {Name = "Metal", Item = 'HD_metal', Chance = 4},
            [3] = {Name = "Spare Change", Item = 'HD_sChange', Chance = 6},
            [4] = {Name = "Plug", Item = 'HD_plug', Chance = 4}
        },
        Tasks = {
            [1] = {
                TaskName = "Grab Door",
                TaskLoc = {Loc = vector3(701.91571044922, 165.98364257812, 80.742179870605), Heading = 335.01},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_car_door_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [2] = {
                TaskName = "Drop Off Door",
                TaskLoc = {Loc = vector3(676.87237548828, 179.84175109863, 81.492622375488), Heading = 67.03},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [3] = {
                TaskName = "Grab Door",
                TaskLoc = {Loc = vector3(702.71710205078, 168.6258392334, 80.732131958008), Heading = 162.6},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_car_door_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [4] = {
                TaskName = "Drop Off Door",
                TaskLoc = {Loc = vector3(676.87237548828, 179.84175109863, 81.492622375488), Heading = 67.03},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [5] = {
                TaskName = "Grab Door",
                TaskLoc = {Loc = vector3(706.20330810547, 166.10362243652, 80.743278503418), Heading = 69.35},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_car_door_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [6] = {
                TaskName = "Drop Off Door",
                TaskLoc = {Loc = vector3(676.87237548828, 179.84175109863, 81.492622375488), Heading = 67.03},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            }
        }
    },
    [7] = {
        Name = "Engine Builder",
        TimeRemove = 25,
        StealChance = 3,
        StealItems = {
            [1] = {Name = "Metal", Item = 'HD_metal', Chance = 4},
            [2] = {Name = "Plug", Item = 'HD_plug', Chance = 4}
        },
        Tasks = {
            [1] = {
                TaskName = "Grab Part",
                TaskLoc = {Loc = vector3(683.09381103516, 172.2978515625, 80.742240905762), Heading = 160.55},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_car_exhaust_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [2] = {
                TaskName = "Put On Engine",
                TaskLoc = {Loc = vector3(682.29986572266, 178.68197631836, 81.49259185791), Heading = 339.26},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [3] = {
                TaskName = "Grab Part",
                TaskLoc = {Loc = vector3(680.64508056641, 179.74719238281, 81.49259185791), Heading = 307.45},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_car_exhaust_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [4] = {
                TaskName = "Put On Engine",
                TaskLoc = {Loc = vector3(682.29986572266, 178.68197631836, 81.49259185791), Heading = 339.26},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [5] = {
                TaskName = "Grab Part",
                TaskLoc = {Loc = vector3(689.52160644531, 176.32487487793, 80.742248535156), Heading = 335.77},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_car_exhaust_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [6] = {
                TaskName = "Put On Engine",
                TaskLoc = {Loc = vector3(682.29986572266, 178.68197631836, 81.49259185791), Heading = 339.26},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [7] = {
                TaskName = "Grab Part",
                TaskLoc = {Loc = vector3(674.92645263672, 177.18450927734, 80.742218017578), Heading = 80.65},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_car_exhaust_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [8] = {
                TaskName = "Put On Engine",
                TaskLoc = {Loc = vector3(682.29986572266, 178.68197631836, 81.49259185791), Heading = 339.26},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            }
        }
    }
}

--Uniform Configs
Config.Uniforms = { --The outfit for the uniforms
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1']  = 146, ['torso_2']  = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms']     = 0,   ['pants_1']  = 5,
        ['pants_2']  = 7,   ['shoes_1']  = 6,
        ['shoes_2']  = 0,   ['mask_1']   = 0,
        ['mask_2']   = 0,   ['bproof_1'] = 0,
        ['bproof_2'] = 0,   ['chain_1']  = 0,
        ['chain_2']  = 0,   ['helmet_1'] = -1,
        ['helmet_2'] = 0,   ['glasses_1'] = 0,
        ['glasses_2'] = 0
    },
    female = {
        ['tshirt_1'] = 15,   ['tshirt_2'] = 0,
        ['torso_1']  = 118,  ['torso_2']  = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms']     = 4,   ['pants_1']  = 4,
        ['pants_2']  = 5,  ['shoes_1']  = 16,
        ['shoes_2']  = 0,   ['mask_1']   = 0,
        ['mask_2']   = 0,   ['bproof_1'] = 0,
        ['bproof_2'] = 0,   ['chain_1']  = 0,
        ['chain_2']  = 0,   ['helmet_1'] = -1,
        ['helmet_2'] = 0,   ['glasses_1'] = 0,
        ['glasses_2'] = 0
    }
}

--Cell Configs
Config.Cells = { --All cells in the prison
    [1] = {
        SpawnLoc = {Loc = vector3(676.76263427734, 91.517692565918, 80.717613220215), Heading = 258.52}, --Spawning in location (usually the middle of cell)
        InvLoc = {Loc = vector3(677.54907226562, 90.771553039551, 80.717613220215), Heading = 273.29}, --Inventory location or Bed location
        BreakLoc = {Loc = vector3(676.32568359375, 89.872703552246, 80.717628479004), Heading = 172.18}, --Breaking out location 
        ExitLoc = {Loc = vector3(688.21978759766, 86.48902130127, 84.788917541504), Heading = 240.51} --Exit after crawling throug for breakout (usually on outside of building)
    },
    [2] = {
        SpawnLoc = {Loc = vector3(673.15814208984, 90.977043151855, 80.71753692627), Heading = 0.41},
        InvLoc = {Loc = vector3(673.88336181641, 90.919242858887, 80.71753692627), Heading = 270.39},
        BreakLoc = {Loc = vector3(673.91009521484, 89.723289489746, 80.71753692627), Heading = 201.44},
        ExitLoc = {Loc = vector3(686.93048095703, 83.050514221191, 85.012092590332), Heading = 248.96}
    },
    [3] = {
        SpawnLoc = {Loc = vector3(669.43048095703, 90.928993225098, 80.717597961426), Heading = 359.14},
        InvLoc = {Loc = vector3(670.03430175781, 90.860885620117, 80.717597961426), Heading = 273.68},
        BreakLoc = {Loc = vector3(669.17785644531, 89.611938476562, 80.717597961426), Heading = 180.97},
        ExitLoc = {Loc = vector3(687.36822509766, 79.991767883301, 85.090621948242), Heading = 251.37}
    },
    [4] = {
        SpawnLoc = {Loc = vector3(665.64544677734, 90.998733520508, 80.71760559082), Heading = 1.13},
        InvLoc = {Loc = vector3(666.43701171875, 90.858207702637, 80.71760559082), Heading = 268.81},
        BreakLoc = {Loc = vector3(665.97961425781, 89.422790527344, 80.71760559082), Heading = 176.16},
        ExitLoc = {Loc = vector3(663.86138916016, 53.735649108887, 86.890754699707), Heading = 161.6}
    },
    [5] = {
        SpawnLoc = {Loc = vector3(676.90307617188, 90.936073303223, 83.941482543945), Heading = 2.6},
        InvLoc = {Loc = vector3(677.73071289062, 90.958274841309, 83.941482543945), Heading = 269.66},
        BreakLoc = {Loc = vector3(676.50518798828, 89.882781982422, 83.941482543945), Heading = 154.31},
        ExitLoc = {Loc = vector3(688.10412597656, 85.614318847656, 91.580238342285), Heading = 262.31}
    },
    [6] = {
        SpawnLoc = {Loc = vector3(673.2412109375, 91.148414611816, 83.941474914551), Heading = 351.76},
        InvLoc = {Loc = vector3(673.94183349609, 90.997955322266, 83.941474914551), Heading = 266.24},
        BreakLoc = {Loc = vector3(673.24230957031, 89.661117553711, 83.941474914551), Heading = 178.93},
        ExitLoc = {Loc = vector3(687.03405761719, 83.050064086914, 92.131553649902), Heading = 268.93}
    },
    [7] = {
        SpawnLoc = {Loc = vector3(669.41180419922, 91.001762390137, 83.941543579102), Heading = 354.92},
        InvLoc = {Loc = vector3(670.03112792969, 90.928581237793, 83.941543579102), Heading = 271.21},
        BreakLoc = {Loc = vector3(670.22332763672, 89.642036437988, 83.941543579102), Heading = 229.21},
        ExitLoc = {Loc = vector3(687.4853515625, 79.912490844727, 92.456611633301), Heading = 259.42}
    },
    [8] = {
        SpawnLoc = {Loc = vector3(665.86859130859, 90.996589660645, 83.941558837891), Heading = 5.04},
        InvLoc = {Loc = vector3(666.46228027344, 91.00025177002, 83.941558837891), Heading = 270.62},
        BreakLoc = {Loc = vector3(665.25421142578, 89.489311218262, 83.941558837891), Heading = 152.68},
        ExitLoc = {Loc = vector3(659.77624511719, 54.14599609375, 92.825057983398), Heading = 230.68}
    }
}

--Solitary Configs
Config.Solitary = false --If you want there to be solitary

Config.Sol4Run = true --If you want solitary for when they run away without using the jail script (ex. Using emotes to get through fences and other stuff)
Config.SolRunTime = 1 --Time in mins for the one above

Config.FailBreakToSol = true --If you want solitary for when they fail to breakout in time
Config.SolBreakTime = 1 --Time in mins for the one above

Config.Sol4Lock = false --If you want solitary for when they try to leave their cell on lockdown
Config.SolLockTime = 1 --Time in mins for the one above

Config.Sol4Kill = true --IF you want solitary for when you kill someone
Config.SolKillTime = 1 --Time in mins for the one above

Config.SolCells = { --All of the solitary locations
    [1] = {Loc = vector3(1765.9615478516, 2597.2072753906, 50.549640655518), Heading = 89.81},
    [2] = {Loc = vector3(1765.9827880859, 2594.2705078125, 50.54963684082), Heading = 93.12},
    [3] = {Loc = vector3(1765.9401855469, 2591.3493652344, 50.549640655518), Heading = 89.13},
    [4] = {Loc = vector3(1765.7937011719, 2588.3737792969, 50.549644470215), Heading = 93.71},
    [5] = {Loc = vector3(1762.1220703125, 2588.2312011719, 50.549640655518), Heading = 271.49},
    [6] = {Loc = vector3(1762.0230712891, 2591.0876464844, 50.549640655518), Heading = 269.32},
    [7] = {Loc = vector3(1762.1560058594, 2594.0744628906, 50.549644470215), Heading = 268.63},
    [8] = {Loc = vector3(1761.8892822266, 2597.021484375, 50.549640655518), Heading = 278.27}
}

--Revive Configs
Config.Hospital = true --If you want the hospital
Config.DoctorPed = 's_m_m_doctor_01' --Doctor ped for the hospital
Config.CheckUpTime = 10 --How long it takes to checkup a prisoner (in secs)
Config.BedLocs = {
    [1] = {
        SpawnLoc = {Loc = vector3(722.89965820312, 162.35496520996, 81.646682739258), Heading = 143.52}, --Ped Spawn location
        DoctorSpawn = {Loc = vector3(725.84002685547, 158.4948425293, 80.717910766602), Heading = 54.32}, --Doctor spawn location
        DocCheck = {Loc = vector3(722.31195068359, 161.02990722656, 80.717910766602), Heading = 331.34}, --Where the doctor walks to, to check up
        DocWalkTime = 5 --How long it should take the doctor to walk there (in secs)
    },
    [2] = {
        SpawnLoc = {Loc = vector3(721.42486572266, 163.39050292969, 81.652908325195), Heading = 145.36},
        DoctorSpawn = {Loc = vector3(725.84002685547, 158.4948425293, 80.717910766602), Heading = 54.32},
        DocCheck = {Loc = vector3(720.65185546875, 161.83700561523, 80.71800994873), Heading = 328.25},
        DocWalkTime = 6
    }
}

--All Breaking Out Configs
Config.Breakout = true --If prisoners can breakout of the prison
Config.BreakHole = 5 --How many successful digs they need

Config.CrawlTime = 15 --How long it takes to crawl through the wall (in secs)
Config.BreakoutTime = 120  --How long they are able to breakout before being caught (in seconds)

Config.BreakMarkNum = 22 --Breakout marker num
Config.BreakMarkColor = {r = 255, g = 255, b = 255} --Breakout marker color
Config.BreakMarkSize = {x = 0.5, y = 0.5, z = 0.5} --Breakout marker size

Config.SeeBreakDist = 15 --How close you have to be to see the markers
Config.BreakTextDist = 1 --How close you have to be to use
Config.BreakBlips = {Spawn = true, Sprite = 186, Color = 49, Size = 0.5} --Blips for all breakout / cutting locations

Config.BreakLocs = { --All cutting / digging locations when breaking out (StartLoc is the location to do the anim and the marker, ExitLoc is where they are tp'd, ExitFence is only true if its the last exit before they are completely out of the prison)
    [1] = {StartLoc = {Loc = vector3(631.1904296875, 64.694259643555, 90.322822570801), Heading = 71.25}, ExitLoc = {Loc = vector3(628.77496337891, 65.51335144043, 89.49333190918), Heading = 71.25}, ExitFence = true},
    [2] = {StartLoc = {Loc = vector3(637.92596435547, 59.980113983154, 89.409248352051), Heading = 162.56}, ExitLoc = {Loc = vector3(637.31768798828, 58.023860931396, 88.240242004395), Heading = 162.0}, ExitFence = true},
    [3] = {StartLoc = {Loc = vector3(646.91430664062, 56.775726318359, 88.469833374023), Heading = 165.93}, ExitLoc = {Loc = vector3(646.20294189453, 53.913391113281, 87.223365783691), Heading = 165.36}, ExitFence = true},
    [4] = {StartLoc = {Loc = vector3(656.37866210938, 53.108020782471, 87.510719299316), Heading = 164.14}, ExitLoc = {Loc = vector3(655.86352539062, 51.280330657959, 86.291069030762), Heading = 163.57}, ExitFence = true},
    [5] = {StartLoc = {Loc = vector3(663.62042236328, 50.458038330078, 86.795127868652), Heading = 162.46}, ExitLoc = {Loc = vector3(663.05261230469, 48.645896911621, 85.660118103027), Heading = 161.9}, ExitFence = true},
    [6] = {StartLoc = {Loc = vector3(669.94189453125, 47.951999664307, 86.296455383301), Heading = 156.29}, ExitLoc = {Loc = vector3(669.22332763672, 46.164493560791, 85.154510498047), Heading = 161.17}, ExitFence = true},
    [7] = {StartLoc = {Loc = vector3(676.48254394531, 45.052520751953, 85.72925567627), Heading = 156.06}, ExitLoc = {Loc = vector3(675.75231933594, 43.406173706055, 84.651542663574), Heading = 156.06}, ExitFence = true},
    [8] = {StartLoc = {Loc = vector3(682.81427001953, 41.673984527588, 85.336631774902), Heading = 160.25}, ExitLoc = {Loc = vector3(682.158203125, 39.84175491333, 84.28532409668), Heading = 160.25}, ExitFence = true},
    [9] = {StartLoc = {Loc = vector3(691.38806152344, 42.891986846924, 85.447662353516), Heading = 241.43}, ExitLoc = {Loc = vector3(692.53204345703, 42.273292541504, 84.159523010254), Heading = 240.87}, ExitFence = true},
    [10] = {StartLoc = {Loc = vector3(687.47552490234, 50.81852722168, 85.375053405762), Heading = 339.05}, ExitLoc = {Loc = vector3(688.15179443359, 52.595142364502, 83.69896697998), Heading = 338.48}, ExitFence = true},
    [11] = {StartLoc = {Loc = vector3(678.41705322266, 54.831512451172, 85.66471862793), Heading = 339.02}, ExitLoc = {Loc = vector3(679.18151855469, 56.831043243408, 83.212074279785), Heading = 339.02}, ExitFence = true},
    [12] = {StartLoc = {Loc = vector3(690.75451660156, 76.740875244141, 84.936195373535), Heading = 161.18}, ExitLoc = {Loc = vector3(690.09619140625, 74.79825592041, 83.841232299805), Heading = 160.62}, ExitFence = true},
    [13] = {StartLoc = {Loc = vector3(692.55322265625, 68.826972961426, 84.985260009766), Heading = 63.09}, ExitLoc = {Loc = vector3(691.00964355469, 69.897399902344, 83.819602966309), Heading = 63.09}, ExitFence = true},
    [14] = {StartLoc = {Loc = vector3(687.48455810547, 61.151290893555, 85.20539855957), Heading = 69.57}, ExitLoc = {Loc = vector3(685.42242431641, 61.915866851807, 83.459365844727), Heading = 69.0}, ExitFence = true},
    [15] = {StartLoc = {Loc = vector3(693.84997558594, 55.875385284424, 85.054481506348), Heading = 153.59}, ExitLoc = {Loc = vector3(692.67425537109, 53.499210357666, 83.802665710449), Heading = 153.03}, ExitFence = true},
    [16] = {StartLoc = {Loc = vector3(702.71380615234, 60.481838226318, 84.820556640625), Heading = 238.07}, ExitLoc = {Loc = vector3(706.20251464844, 58.118721008301, 83.882858276367), Heading = 237.44}, ExitFence = true},
    [17] = {StartLoc = {Loc = vector3(713.00726318359, 74.360206604004, 83.849655151367), Heading = 237.79}, ExitLoc = {Loc = vector3(715.16442871094, 73.001083374023, 82.791160583496), Heading = 237.79}, ExitFence = true}
}


Config.RoomTools = { --All the tools for cell and exit locations
    [1] = {
        Name = "Broken Spoon", --Name of the tool
        Item = 'HD_jspoon', --DB item name of the tool
        Time = 10, --How long it takes to use
        Percent = 2 --Percentage chance of it working (ex. 2 = 20%)
    },
    [2] = {
        Name = "Broken Spoon With Wet Cloth",
        Item = 'HD_bCloth',
        Time = 7,
        Percent = 5
    },
    [3] = {
        Name = "Sharp Metal",
        Item = 'HD_sMetal',
        Time = 5,
        Percent = 8
    },
    [4] = {
        Name = "Acid",
        Item = 'HD_acid',
        Time = 20,
        Percent = 8
    },
    [5] = {
        Name = "Mini Hammer",
        Item = 'HD_miniH',
        Time = 25,
        Percent = 9
    }
}

Config.FenceTool = { --Tools for fences that are not exit locations
    [1] = {
        Name = "File", --Name of the tool
        Item = 'HD_file', --DB name of the tool
        Time = 10, --How long it takes
        Percent = 4 --Percentage of it working (ex. 4 = 40%)
    },
    [2] = {
        Name = "Sharp Metal",
        Item = 'HD_sMetal',
        Time = 4,
        Percent = 7
    },
    [3] = {
        Name = "Acid",
        Item = 'HD_acid',
        Time = 20,
        Percent = 9
    },
    [4] = {
        Name = "Mini Hammer",
        Item = 'HD_miniH',
        Time = 15,
        Percent = 7
    },
    [5] = {
        Name = "Immersion Heater",
        Item = 'HD_iHeat',
        Time = 20,
        Percent = 9
    }
}


Config.WatchMarkNum = 1 --Watch tower marker num
Config.WatchMarkColor = {r = 255, g = 0, b = 0} --Color of watch tower marker

Config.WatchBlip = {Spawn = true, Sprite = 181, Color = 1, Size = 0.7} --Watch tower blip configs
Config.WatchDist = 30.0 --How big the circle is or how close you have to be
Config.MaxWatchDist = 150 --How far you have to get to fully escape
Config.SeeWatchDist = 75 --How close you have to be to see the 3d circle
Config.WatchTowers = { --All watch tower locations
    [1] = vector3(641.34552001953, 92.298652648926, 89.763366699219),
    [2] = vector3(674.93579101562, 182.78100585938, 91.947387695312),
    [3] = vector3(740.66595458984, 144.14059448242, 88.39835357666)
}

--Showering Configs
Config.Showers = true --If you want there to be showers in the prison
Config.ShowerLoc = {Loc = vector3(653.09490966797, 98.346435546875, 84.081146240234), Heading = 16.07} --Change location for the showers
Config.ShowerBlip = {Spawn = true, Sprite = 365, Color = 29, Size = 0.7} -- Blip configs for the shower

Config.ShowMarkNum = 21 --Shower 3d marker num
Config.ShowMarkColor = {r = 50, g = 109, b = 168} --Shower 3d marker color
Config.ShowMarkSize = {x = 0.5, y = 0.5, z = 0.5} --Shower 3d marker size

Config.GetReadyTime = 5 --How long it takes to change
Config.ShowerFullDist = 7 --How close you have to be to see the 3d marker
Config.ShowerMarkerDist = 10 --How close you have to see intial marker
Config.ShowerDist = 1 --How close you have to be to use the shower
Config.MaxDistShower = 20 --How far you can get before it cancels the shower

Config.ShowerLocs = { --All shower locations
    [1] = vector3(650.32366943359, 98.973274230957, 83.998268127441),
    [2] = vector3(648.04595947266, 98.989273071289, 83.99828338623),
    [3] = vector3(645.72790527344, 98.932479858398, 83.998268127441),
    [4] = vector3(643.54931640625, 92.418090820312, 83.998275756836),
    [5] = vector3(645.54211425781, 91.611404418945, 83.99828338623),
    [6] = vector3(647.66302490234, 90.932395935059, 83.998268127441),
    [7] = vector3(649.99786376953, 90.065582275391, 83.998268127441)
}

Config.ShowerFit = { --Shower outfit (should be a naked ped or ped with trousers on)
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1']  = 15, ['torso_2']  = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms']     = 15,   ['pants_1']  = 21,
        ['pants_2']  = 0,   ['shoes_1']  = 34,
        ['shoes_2']  = 0,   ['mask_1']   = 0,
        ['mask_2']   = 0,   ['bproof_1'] = 0,
        ['bproof_2'] = 0,   ['chain_1']  = 0,
        ['chain_2']  = 0,   ['helmet_1'] = -1,
        ['helmet_2'] = 0,   ['glasses_1'] = 0,
        ['glasses_2'] = 0
    },
    female = {
        ['tshirt_1'] = 15,   ['tshirt_2'] = 0,
        ['torso_1']  = 15,  ['torso_2']  = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms']     = 15,   ['pants_1']  = 15,
        ['pants_2']  = 0,  ['shoes_1']  = 35,
        ['shoes_2']  = 0,   ['mask_1']   = 0,
        ['mask_2']   = 0,   ['bproof_1'] = 0,
        ['bproof_2'] = 0,   ['chain_1']  = 0,
        ['chain_2']  = 0,   ['helmet_1'] = -1,
        ['helmet_2'] = 0,   ['glasses_1'] = 0,
        ['glasses_2'] = 0
    }
}

--Working Out
Config.WorkingOut = true --If you can workout in prison

Config.WorkOutBlip = {Spawn = true, Sprite = 354, Color = 1, Size = 0.7} --All blip configs for workout areas

Config.WoutMarkNum = 21 --Workout 3d Marker Nums
Config.WoutMarkColor = {r = 255, g = 0, b = 0} --Workout 3d Marker Colors
Config.WoutMarkSize = {x = 0.5, y = 0.5, z = 0.5} --Workout 3d Marker Size

Config.WorkoutLocs = { --All diffrent workout areas
    [1] = {
        StartLoc = {Loc = vector3(690.77770996094, 102.13820648193, 80.754173278809), Heading = 351.03}, --Starting location for changing in this area
        Locs = { --All workout locations in area (Label = Name of task, Loc = location of marker, Heading = direction you are facing, Anim.Dict = Animation Dictionary / Scenario, Anim.Aim = Animation thats played within that Dictionary(leave nil if scenario), Time = How long it plays anim (in secs))
            [3] = {Label = "Pullups", Loc = vector3(696.18542480469, 94.335205078125, 80.754173278809), Heading = 334.16, Anim = {Dict = 'PROP_HUMAN_MUSCLE_CHIN_UPS', Aim = nil}, Time = 10},
            [5] = {Label = "Pushups", Loc = vector3(683.33392333984, 96.211631774902, 80.754180908203), Heading = 93.29, Anim = {Dict = 'amb@world_human_push_ups@male@idle_a', Aim = 'idle_d'}, Time = 10},
            [6] = {Label = "Pushups", Loc = vector3(682.86871337891, 93.656059265137, 80.754180908203), Heading = 90.47, Anim = {Dict = 'amb@world_human_push_ups@male@idle_a', Aim = 'idle_d'}, Time = 10},
            [7] = {Label = "Yoga", Loc = vector3(691.77581787109, 96.979164123535, 80.754180908203), Heading = 330.27, Anim = {Dict = 'WORLD_HUMAN_YOGA', Aim = nil}, Time = 10},
            [8] = {Label = "Yoga", Loc = vector3(689.255859375, 98.440948486328, 80.754180908203), Heading = 331.35, Anim = {Dict = 'WORLD_HUMAN_YOGA', Aim = nil}, Time = 10}
        }
    }
}

Config.SeeWorkDist = 7 --How close you have to be to see 3D marker
Config.WorkReadyTime = 5 --How long it takes to get ready for a workout (in secs)
Config.MaxDistWorkout = 10 --How far you have to be for it to auto cancel workout
Config.WorkText = 1 --How close you have to be to see work text
Config.WorkoutFit = { --Workout fit for female and male
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1']  = 15, ['torso_2']  = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms']     = 15,   ['pants_1']  = 42,
        ['pants_2']  = 2,   ['shoes_1']  = 6,
        ['shoes_2']  = 0,   ['mask_1']   = 0,
        ['mask_2']   = 0,   ['bproof_1'] = 0,
        ['bproof_2'] = 0,   ['chain_1']  = 0,
        ['chain_2']  = 0,   ['helmet_1'] = -1,
        ['helmet_2'] = 0,   ['glasses_1'] = 0,
        ['glasses_2'] = 0
    },
    female = {
        ['tshirt_1'] = 15,   ['tshirt_2'] = 0,
        ['torso_1']  = 15,  ['torso_2']  = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms']     = 15,   ['pants_1']  = 2,
        ['pants_2']  = 0,  ['shoes_1']  = 16,
        ['shoes_2']  = 0,   ['mask_1']   = 0,
        ['mask_2']   = 0,   ['bproof_1'] = 0,
        ['bproof_2'] = 0,   ['chain_1']  = 0,
        ['chain_2']  = 0,   ['helmet_1'] = -1,
        ['helmet_2'] = 0,   ['glasses_1'] = 0,
        ['glasses_2'] = 0
    }
}


--All Sayings
Config.RanMessages = {
    [1] = "You smell! Go take a shower!",
    [2] = "You're lookin weak! Go workout!",
    [3] = "You're being lazy! Go do your job!"
}

Config.Sayings = { --All sayings in the whole script
    [1] = "Prison",
    [2] = "Doing Task",
    [3] = " ~y~Jail~w~ | Time Left:~r~ ",
    [4] = "(s) ~w~| Job =~o~ ",
    [5] = "You Are Being Sent To Jail",
    [6] = "None",
    [7] = "Judge ",
    [8] = " is being sentenced ",
    [9] = "Jail Job Manager",
    [10] = "Old Man",
    [11] = "Jail Item Retreival",
	[12] = "[~p~E~w~] Retreive Items",
    [13] = "Grabbing Belongings",
    [14] = "[~p~E~w~] Job Manager",
    [15] = "Available Jobs",
    [16] = "No Job",
    [17] = "Tasks: ",
    [18] = "Time Deduction: ",
    [19] = "Start Job",
    [20] = "You chose a job! Go do the tasks!",
    [21] = "(mins) in Bolingbroke Penitentiary | Reason: ",
    [22] = "[~y~E~w~] ",
    [23] = "Doing Task",
    [24] = "You completed a task! Go to the next task!",
    [25] = "You completed all the tasks! Your time was reduced and tasks reset!",
    [26] = "Task: ",
    [27] = "[~y~E~w~] Old Man",
    [28] = "[~o~E~w~] Start Digging",
    [29] = "[~b~E~w~] Lift Bed",
    [30] = "[~g~E~w~] Get Food",
    [31] = "Inventory",
    [32] = "Food Court",
    [33] = "No Items",
    [34] = "Under the Bed",
    [35] = "Lifting Bed",
    [36] = "Lowering Bed",
    [37] = "How many do you want to pull out?",
    [38] = "Invalid Amount/Message",
    [39] = "Amount is too much",
    [40] = "Remove Items",
    [41] = "Add Items",
    [42] = "How many would you like to add?",
    [43] = "Grabbing tray of food",
    [44] = "[~y~E~w~] Eat Food [~g~G~w~] Throw Away",
    [45] = "What would you like to talk about?",
    [46] = "Breaking out of here",
    [47] = "Making Items",
    [48] = "What were you looking to make?",
    [49] = "What about breaking out?",
    [50] = "What I need",
    [51] = "Make it",
    [52] = "Needed",
    [53] = " ~r~Solitary ~w~| Time Left: ~y~",
    [54] = "~w~(~r~s~w~)",
    [55] = "Jailing Info",
    [56] = "ID: ",
    [57] = "Time: ",
    [58] = "Time: None",
    [59] = "Reason",
    [60] = "Confirm",
    [61] = "Change ID For Jailing",
    [62] = "Jail Time is too long, above max Jail Time!",
    [63] = "Change Time Amount",
    [64] = "Reason For Jailing",
    [65] = "Edit Reason",
    [66] = "Confirm Reason",
    [67] = "See Reason",
    [68] = "Reason For Jail",
    [69] = "None",
    [70] = "The Doctor Is Checking You Up",
    [71] = "What would you like to know?",
    [72] = "Breaking Out Of Cell",
    [73] = "Breaking Through Fence 1",
    [74] = "Breaking Through Fence 2",
    [75] = "Description",
    [76] = "Tools that can be used",
    [77] = "You need a tool to dig through the wall! Once you make a hole you can climb through!",
    [78] = "You need a tool to cut through the fence! Once you cut through you can climb through!",
    [79] = "You need a tool to dig through the ground and wall! Once you make a hole you can crawl out!",
    [80] = "Time: ",
    [81] = "~w~(~y~s~w~)",
    [82] = "Success Percentage: ",
    [83] = "Missing Items To Craft",
    [84] = "Action Not Possible",
    [85] = "Crafting",
    [86] = "You stole a ",
    [87] = "What would you like to dig with?",
    [88] = "You do not have this item!",
    [89] = "[~o~E~w~] Break Out",
    [90] = "You your dig was successful",
    [91] = "Your tool broke",
    [92] = "You Are ~b~Breaking Out~w~! | Time Until Gaurds Notice:~o~ ",
    [93] = "[~g~E~w~] Cut Fence",
    [94] = "What would you like to cut with?",
    [95] = "You don't have this item!",
    [96] = "Digging",
    [97] = "Cutting",
    [98] = "Dig / Cut",
    [99] = "Watch Tower",
    [100] = "You have to successfully dig ",
    [101] = " times to go through the wall!",
    [102] = "You finished digging! Crawl through the hole to start your escape!",
    [103] = "That ID is not in jail!",
    [104] = "(s) was added to your sentence!",
    [105] = "Your reason is invalid",
    [106] = "Your ID is invalid",
    [107] = "Your time is invalid",
    [108] = "Failed To Break Out In Time",
    [109] = "Got To Far From Prison",
    [110] = "Killed Someone In Prison",
    [111] = "You walked too far away and the Menu Closed!",
    [112] = "Showers",
    [113] = "[~b~E~w~] Get Ready For Shower",
    [114] = "Changing Clothes",
    [115] = "Go to one of the showers",
    [116] = "[~b~G~w~] Shower",
    [117] = "Shower Cancelled! You walked to far away!",
    [118] = "Showering",
    [119] = "Working Out",
    [120] = "[~r~E~w~] Start Working Out",
    [121] = "You are working out! Go and use one of the machines or use the ground!",
    [122] = "[~r~G~w~] ",
    [123] = "Working Out",
    [124] = "Workout Cancelled! You walked to far away!",
    [125] = "Workout Ended",
    [126] = "[~r~E~w~] End Working Out",
    [127] = "Invalid ID",
    [128] = "Jail Someone",
    [129] = "UnJail Someone",
    [130] = "Add Time to Someone",
    [131] = "Remove Time from Someone",
    [132] = "Send Someone to Solitary",
    [133] = "Jail Options",
    [134] = "Enter ID of Player",
    [135] = "No Players Nearby",
    [136] = "Solitary Is Not Allowed",

    [137] = " ~y~Jail~w~ | Time:~r~ ",
    [138] = " | Job =~o~ ",
    [139] = "Eating",
    [140] = " was added to your sentence!",
    [141] = "Time is too much to remove!",
    [142] = " was removed from your sentence!",
    [143] = "(s) was removed from your sentence!",
    [144] = "Remove Someone From Solitary",
    [145] = "Lockdown: ",
    [146] = "On",
    [147] = "Off",
    [148] = "Can't Turn On/Off Lockdown, Currently Counting Down!",
    [149] = "(s) Until Lockdown! Get to Your Cell!",
    [150] = "Left Cell During Lockdown",
    [151] = "No Longer in LockDown",
    [152] = "You are now in LockDown!",
    [153] = "LockDown Started, Will be in Effect in ",
    [154] = "(s)!",
    [155] = "All Players In This Cell",
    [156] = " | ID: ",
    [157] = "'s Bed",
    [158] = "[~o~E~w~] Lift Bed",
    [159] = "Action Not Allowed",
    [160] = "Prison",
    [161] = "Crawling Through Hole",
    [162] = "Cant use!",
    [163] = "You drank some booze!",
    [164] = "You drank some punch!",
    [165] = "Notify All Prisoners",
    [166] = "What would you like to tell them?",
    [167] = "Can't confirm! Invalid reason!",
    [168] = "[Prison Intercom] : ",

    [169] = "In This Prison You Can",
    [170] = "~y~Work A Job To Get Time Removed",
    [171] = "~g~Grab Food To Eat",
    [172] = "~r~Get Sent To Solitary",
    [173] = "~o~Workout To Get Strong",
    [174] = "~b~Take Showers To Stay Clean",
    [175] = "~r~Get Help From A Doctor",
    [176] = "~y~Retrive Items Upon Release",
    [177] = "~g~Much More Hidden Things",
    [178] = " Is Not In Their Cell! They Escaped The Jail!"
}