Config = {}
-- No modificar
Config.CurrentV = "1.0 HD" -- No modificar

-- Configuraciones Importantes
Config.OLDESX = false -- Si estás usando un Sistema de Peso = false, Sistema de Límites = true
Config.ESXVersion = '1.2' -- Ejemplos (1.0, 1.1, 1.2)
Config.MenuLoc = 'right' -- Dónde se mostrarán todos los menús de ESX en este scrip
Config.Notifications = 'esx' -- Puede ser {esx, mythic, tnotify}
Config.UsingHDBlips = true -- Esto es si estás usando mi script de manejo gratuito de indicadores (blips). Si es así, solo funcionará para el indicador de prisión.
Config.SyncInterval = 2 -- Con qué frecuencia el servidor actualiza la base de datos para los tiempos restantes de los jugadores
Config.MaxPerCell = 2 -- Cuántos están permitidos por celda. Se recomienda dejarlo alto.
Config.MaxJail = 600 -- La cantidad máxima por la que alguien puede ser inicialmente encarcelado.

Config.ServerName = 'Fixlife RP' -- Nombre del servidor que se mostrará en el texto 2D. Si quieres que esté en blanco, déjalo en blanco.

Config.PoliceNotifyTime = 5 -- Cuánto tiempo tarda la policía en enterarse de que alguien escapó (en minutos).
Config.PoliceRoles = { -- Todos los roles de la policía para que tengan acceso a buscar y usar el menú.
    'police'
}
Config.PoliceRanks = { -- Todos los rangos que pueden usar ciertas cosas en el menú.
    Jailing = { --mandar a prision
        {Job = 'police', Grade = 1}
    },
    UnJail = { --sacar de prision
        {Job = 'police', Grade = 1}
    },
    AddTime = { --añadir tiempo
        {Job = 'police', Grade = 1}
    },
    RemoveTime = { --remover tiempos
        {Job = 'police', Grade = 5}
    },
    Send2Solitary = { --mandar a solitario
        {Job = 'police', Grade = 2}
    },
    RemoveFromSolitary = { ---quitar de solitario
        {Job = 'police', Grade = 2}
    },
    Lockdown = { --bloquear celdas
        {Job = 'police', Grade = 2}
    },
    Message = { --mensaje a la prision
        {Job = 'police', Grade = 4}
    }
}
Config.DefaultSetJob = {Name = 'unemployed', Grade = 0} -- Este es el trabajo predeterminado que se establecerá si no está guardado de alguna manera en la base de datos
Config.SimpleTime = false -- Esto es si deseas que el tiempo sea en segundos solamente, se recomienda dejarlo en false

-- Configuraciones Generales
Config.SeeDist = 5 -- Qué tan cerca debes estar para ver los marcadores 3D
Config.TextDist = 1 -- Qué tan cerca debes estar para ver el texto 3D
Config.TextLift = 0.3 -- Cuánto se eleva el texto 3D sobre el marcador

Config.JailBlip = {Spawn = false, Sprite = 238, Color = 1, Size = 0.7} -- Todas las configuraciones relacionadas con el indicador (blip) de la prisión
Config.JailLoc = vector3(3908.3909, 25.6009, 48.8995) -- Ubicación de la prisión (generalmente el centro para que no dé lugar a errores al verificar la ubicación)
Config.TpBack = true -- Si los jugadores son teleportados de regreso cuando salen de la prisión sin usar el script de escape (se recomienda mantenerlo en true)
Config.MaxTpDist = 250 -- A qué distancia se te teleportará de regreso
Config.MaxSolTpDist = 5 -- A qué distancia te teleportará de regreso desde la celda de castigo
Config.MaxMenuDist = 2 -- A qué distancia puedes alejarte antes de que el menú de ESX se cierre automáticamente

Config.RanMessage = true -- Si da notificaciones aleatorias para los prisioneros
Config.RanMessageTime = 5 -- Cada cuánto tiempo envía un mensaje (en minutos)
-- Configuraciones de Bloqueo
Config.StartLockCount = 60 -- Tiempo inicial para el bloqueo (en segundos)
Config.WarnLockNums = {45, 30, 15, 10, 5, 4, 3, 2, 1} -- Todas las notificaciones de advertencia para el tiempo de bloqueo, asegúrate de que estén dentro del número anterior

Config.LockDownDist = 4 -- Cuánto puedes alejarte de la celda antes de ser teleportado de regreso o enviado a la celda de castigo

-- Configuraciones de Búsqueda Policial
Config.PoliceCanSearchInv = true -- Si la policía puede registrar los inventarios

Config.SeePoliceDist = 5 -- Qué tan cerca debes estar para ver los marcadores 3D
Config.UsePoliceDist = 1 -- Qué tan cerca debes estar para ver el texto 3D
Config.PMarkNum = 22 -- Número del marcador
Config.PMarkColor = {r = 235, g = 116, b = 52} -- Colores del marcador
Config.PMarkSize = {x = 0.5, y = 0.5, z = 0.3} -- Tamaño del marcador

-- Configuraciones de Objetos Utilizables
Config.ShankWeapon = 'weapon_knife' -- Nombre del arma para el shank (no cambiar)
Config.ShankItem = true -- Si el shank/arma se usa en el inventario de la barra de acceso rápido
Config.ShankAllowed = true -- Si se puede usar el shank

Config.BoozeAllowed = true -- Si se puede usar el objeto booze
Config.BoozeEffect = true -- Si el consumo de booze tiene un efecto
Config.BoozeGive = 80000 -- Cuánta sed se sacia al beber booze (de 1,000,000)
Config.BoozeProp = nil -- Prop a generar mientras se usa el objeto (dejar nil si deseas la copa predeterminada)
Config.BoozeEffectTime = 30 -- Cuánto tiempo dura el efecto

Config.PunchAllowed = true -- Si se puede usar el objeto punch
Config.PunchGive = 100000 -- Cuánta sed se sacia al beber punch (de 1,000,000)
Config.PunchProp = nil -- Prop a generar mientras se usa el objeto (dejar nil si deseas el vaso predeterminado)

-- Guía de Entrada
Config.HaveGuide = true -- Si hay una guía de la prisión cuando son enviados por primera vez
Config.TimePer = 5 -- Cuánto tiempo por cámara para la guía (en segundos)


Config.PrisonCam = vector3(3911.7275, -132.4698, 89.8866) --Posición de la vista de la cámara
Config.PrisonCamRot = {x = -35.0, y = 0.0, z = -10.0} --Rotación de la vista de la cámara
Config.PrisonIntroDuration = 20
Config.PrisonIntroBlend = 1200
Config.PrisonIntroBank = 6.0
Config.PrisonIntroBob = 0.12
Config.PrisonIntroPath = {
    {Mode = 'Orbit', From = vector3(3720.70044, 32.40902, 53.0), To = vector3(3810.63916, -72.59, 53.0), Center = vector3(3810.63916, 32.40902, 14.8724775), Direction = 1},
    {Mode = 'Linear', From = vector3(3810.63916, -72.59, 53.0), To = vector3(4065.01123, -72.59, 53.0), FixedRotation = {x = -18.0, y = 0.0, z = 0.0}},
    {Mode = 'Orbit', From = vector3(4065.01123, -72.59, 53.0), To = vector3(4162.24072, 28.1750088, 53.0), Center = vector3(4065.01123, 28.1750088, 17.7991829), Direction = 1}
}

Config.JobCam = vector3(3915.46, 24.37, 23.89) --Posición de la vista de la cámara
Config.JobCamRot = {x = 0.0, y = 0.0, z = 180.0} --Rotación de la vista de la cámara

Config.SolCam = vector3(3889.2332, 26.5927, 27.4285) --Posición de la vista de la cámara (Solo se muestra si el aislamiento está activado)
Config.SolCamRot = {x = -10.0, y = 0.0, z = 90.0} --Rotación de la vista de la cámara (Solo se muestra si el aislamiento está activado)

Config.WorkOutCam = vector3(3957.4907, 43.9866, 24.9793) --Posición de la vista de la cámara (Solo se muestra si el ejercicio está activado)
Config.WorkOutCamRot = {x = -25.0, y = 0.0, z = 45.0} --Rotación de la vista de la cámara (Solo se muestra si el ejercicio está activado)

Config.ShowerCam = vector3(3910.1936, 39.0764, 24.9793) --Posición de la vista de la cámara (Solo se muestra si las duchas están activadas)
Config.ShowerCamRot = {x = -20.0, y = 0.0, z = 90.0} --Rotación de la vista de la cámara (Solo se muestra si las duchas están activadas)

Config.FoodCam = vector3(3929.5596, 29.0406, 24.9793) --Posición de la vista de la cámara
Config.FoodCamRot = {x = 0.0, y = 0.0, z = 70.0} --Rotación de la vista de la cámara

Config.HospitalCam = vector3(4032.4121, 0.2040, 20.0884) --Posición de la vista de la cámara (Solo se muestra si el hospital está activado)
Config.HospitalCamRot = {x = -25.0, y = 0.0, z = 180.0} --Rotación de la vista de la cámara (Solo se muestra si el hospital está activado)

Config.ItemCam = vector3(3865.8289, -23.6205, 7.8507) --Posición de la vista de la cámara (Solo se muestra si hay objetos para guardar)
Config.ItemCamRot = {x = -10.0, y = 0.0, z = 0.0} --Rotación de la vista de la cámara (Solo se muestra si hay objetos para guardar)

--Configuraciones de la escena de entrada a prisión (No modificar si no sabes lo que haces)
Config.GuardPed = 'csb_cop' --Personaje que te lleva al interior
Config.GuardSpawn = {Loc = vector3(465.0160, -998.6136, 22.8469), Heading =  300.0} --Ubicación donde aparece el guardia check
Config.HandCuffLoc = {Loc = vector3(465.2975, -999.2302, 22.8469), Heading = 300.0}
Config.ClothesLoc = {Loc = vector3(467.8503, -1001.4005, 22.8469), Heading = 90.0} --Ubicación a la que te lleva el guardia
Config.ClothesProp = 'prop_cs_t_shirt_pile' --Objeto que aparece en las manos y sobre la mesa
Config.ClothPropLoc = {Loc = vector3(466.706726, -1000.86926, 23.75275), Heading = 180.0} --Ubicación donde aparece el objeto

Config.PreComputerLoc = {Loc = vector3(468.1209, -999.9722, 22.8469), Heading = 90.0}

Config.ComputerLoc = {Loc = vector3(465.9052, -1002.4626, 22.8469), Heading = 270.0} --Ubicación donde el guardia mira su computadora
Config.PointLoc = {Loc = vector3(465.9089, -1001.2302, 22.8418), Heading = 270.0} --Ubicación donde llega y señala el guardia
Config.GrabLoc = {Loc = vector3(469.1391, -1000.9457, 22.8469), Heading = 270.0} --Ubicación a la que va el guardia para recoger al jugador
Config.GrabTurnHead = 45.0 --Dirección hacia la salida
Config.PedGrabHeading = 270.0 --Dirección hacia la que miras al ser sujetado
Config.StopnLook = {Loc = vector3(465.6371, -999.6112, 22.8469), Heading = 270.0} --Punto de parada y avance del guardia para evitar problemas
Config.StopnLook2 = 85.28 --Dirección del segundo punto de parada
Config.StopnTurn = {Loc = vector3(464.8575, -998.8878, 22.8469), Heading = 90.0} --Otro punto de parada y avance
Config.Undressed = { --Ropa del jugador sin prendas
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1']  = 346, ['torso_2']  = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms']     = 5,   ['pants_1']  = 346,
        ['pants_2']  = 6,   ['shoes_1']  = 8,
        ['shoes_2']  = 0,   ['mask_1']   = 0,
        ['mask_2']   = 0,   ['bproof_1'] = 0,
        ['bproof_2'] = 0,   ['chain_1']  = 0,
        ['chain_2']  = 0,   ['helmet_1'] = -1,
        ['helmet_2'] = 0,   ['glasses_1'] = 0,
        ['glasses_2'] = 0
    },
    female = {
        ['tshirt_1'] = 14,   ['tshirt_2'] = 0,
        ['torso_1']  = 358,  ['torso_2']  = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms']     = 4,   ['pants_1']  = 179,
        ['pants_2']  = 6,  ['shoes_1']  = 181,
        ['shoes_2']  = 0,   ['mask_1']   = 0,
        ['mask_2']   = 0,   ['bproof_1'] = 0,
        ['bproof_2'] = 0,   ['chain_1']  = 0,
        ['chain_2']  = 0,   ['helmet_1'] = -1,
        ['helmet_2'] = 0,   ['glasses_1'] = 0,
        ['glasses_2'] = 0
    }
}
Config.EnterLoc = vector3(470.2050, -1000.9194, 22.8469) -- Ubicación del letrero
Config.EnterHeadings = {Front = 90.0, Side = 0.0} -- Encabezados del letrero, ambos
Config.WalkLoc = vector3(465.0607, -998.9862, 22.8469) -- Caminata final hacia el destino en el pasillo

Config.Cam = vector3(464.937317, -998.060303, 25.576260)
Config.CamRot = {x = -27.302866, y = 0.061999, z = -141.093887}
Config.TestSceneOnly = false


Config.DontTakeGunUponEntry = { -- Todas las armas que no se quitan al entrar en la cárcel

}
Config.DontTakeItemsUponEntry = { -- Estos son todos los objetos que no se quitan al entrar en la cárcel (objetos en lista blanca)
    -- 'manzana'
    '',
}
Config.DontGiveBackItems = { -- Estos son todos los objetos que no se devolverán al agarrar objetos al salir (objetos en lista negra)
    'meth_glass'
}


Config.AlertServerUponJail = true -- Si se envía un mensaje en el chat cuando alguien es encarcelado

-- Configuraciones de Salida
Config.LeaveLoc = {Loc = vector3(1830.3531494141, 2585.8728027344, 45.954323913574), Heading = 266.75} -- Ubicación de salida con orientación

Config.LMarkNum = 22 -- Número del marcador para recoger objetos
Config.LMarkColor = {r = 235, g = 116, b = 52} -- Color del marcador para recoger objetos
Config.LMarkSize = {x = 0.5, y = 0.5, z = 0.3} -- Tamaño del marcador para recoger objetos
Config.ItemLoc = {Loc = vector3(1832.1635742188, 2584.6281738281, 45.952304840088), Heading = 185.68} -- Ubicación de dónde recoger objetos
Config.ItemBlip = {Spawn = true, Sprite = 475, Color = 1, Size = 0.7} -- Indicador (blip) para recoger objetos
Config.ShowItemDist = 7 -- Distancia para mostrar el marcador 3D
Config.ItemTextDist = 1 -- Distancia para mostrar el texto 3D sobre el marcador
Config.RetreiveTime = 5 -- Cuánto tiempo se necesita para recoger los objetos de nuevo (en segundos)

-- Configuraciones de Comida
Config.GetFoodLoc = {Loc = vector3(3922.36, 32.64, 23.89), Heading = 87.82} -- Dónde agarrar comida en la prisión
Config.FoodBlip = {Spawn = true, Sprite = 269, Color = 0, Size = 0.9} -- Indicador (blip) en el mapa para agarrar comida en la prisión
Config.GrabFoodTime = 5 -- Cuánto tiempo se necesita para agarrar la comida (en segundos)
Config.EatTime = 7 -- Cuánto tiempo se necesita para comer la comida (en segundos)

Config.FoodAmt = 100000 -- Cuánto Hambre se agrega a esx_status (de 1,000,000)
Config.DrinkAmt = 100000 -- Cuánta Sed se agrega a esx_status (de 1,000,000)

Config.FoMarkNum = 29 -- Número del marcador para la comida
Config.FoMarkColor = {r = 46, g = 166, b = 25} -- Color del marcador para la comida
Config.FoMarkSize = {x = 0.5, y = 0.5, z = 0.5} -- Tamaño del marcador para la comida

-- Configuraciones de Escape
Config.BrMarkNum = 32 -- Número del marcador para escapar en la ubicación de la celda
Config.BrMarkColor = {r = 227, g = 122, b = 16} -- Color del marcador para escapar en la ubicación de la celda
Config.BrMarkSize = {x = 0.5, y = 0.5, z = 0.5} -- Tamaño del marcador para escapar en la ubicación de la celda

-- Configuraciones de Inventario
Config.InvBlip = {Spawn = true, Sprite = 273, Color = 0, Size = 0.9} -- Indicador (blip) para el inventario debajo de la cama

Config.OpenCloseTime = 5 -- Cuánto tiempo se necesita para abrir o cerrar el inventario (en segundos)
Config.ChMarkNum = 21 -- Número del marcador para el inventario de la cama
Config.ChMarkColor = {r = 16, g = 83, b = 227} -- Color del marcador para el inventario de la cama
Config.ChMarkSize = {x = 0.5, y = 0.5, z = 0.3} -- Tamaño del marcador para el inventario de la cama



-- Configuración de Creación
Config.Crafts = { -- Todas las cosas que se pueden crear con el Viejo
    [1] = {
        Name = "Cuchillo improvisado",
        Time = 20,
        MakeItem = 'hd_shank',
        Descripe = "¡Puedes usar esto para defensa personal!",
        Needed = {
            [1] = {
                Name = "Cuchara rota",
                Amount = 1,
                Item = 'hd_jspoon'
            },
            [2] = {
                Name = "Monedas",
                Amount = 2,
                Item = 'hd_schange'
            }
        }
    },
    [2] = {
        Name = "Cuchara rota",
        Time = 8,
        MakeItem = 'hd_jspoon',
        Descripe = "¡Puedes usar esto para escapar o para más creaciones!",
        Needed = {
            [1] = {
                Name = "Cuchara",
                Amount = 1,
                Item = 'hd_spoon'
            }
        }
    },
    [3] = {
        Name = "Cuchara rota con trapo húmedo",
        Time = 5,
        MakeItem = 'hd_bcloth',
        Descripe = "¡Puedes usar esto para escapar!",
        Needed = {
            [1] = {
                Name = "Cuchara rota",
                Amount = 1,
                Item = 'hd_jspoon'
            },
            [2] = {
                Name = "Tela húmeda",
                Amount = 1,
                Item = 'hd_wcloth'
            }
        }
    },
    [4] = {
        Name = "Tela húmeda",
        Time = 10,
        MakeItem = 'hd_wcloth',
        Descripe = "¡Puedes usar esto para más creaciones!",
        Needed = {
            [1] = {
                Name = "Limpiador",
                Amount = 1,
                Item = 'hd_cleaner'
            },
            [2] = {
                Name = "Tela",
                Amount = 1,
                Item = 'hd_cloth'
            }
        }
    },
    [5] = {
        Name = "Lima",
        Time = 20,
        MakeItem = 'hd_file',
        Descripe = "¡Puedes usar esto para escapar o para más creaciones!",
        Needed = {
            [1] = {
                Name = "Roca",
                Amount = 2,
                Item = 'hd_rock'
            },
            [2] = {
                Name = "Cucharón roto",
                Amount = 1,
                Item = 'hd_bladle'
            }
        }
    },
    [6] = {
        Name = "Cucharón roto",
        Time = 5,
        MakeItem = 'hd_bladle',
        Descripe = "¡Puedes usar esto para más creaciones!",
        Needed = {
            [1] = {
                Name = "Cucharón",
                Amount = 1,
                Item = 'hd_ladle'
            }
        }
    },
    [7] = {
        Name = "Metal afilado",
        Time = 20,
        MakeItem = 'hd_smetal',
        Descripe = "¡Puedes usar esto para escapar!",
        Needed = {
            [1] = {
                Name = "Metal",
                Amount = 1,
                Item = 'hd_metal'
            },
            [2] = {
                Name = "Roca",
                Amount = 2,
                Item = 'hd_rock'
            },
            [3] = {
                Name = "Lima",
                Amount = 1,
                Item = 'hd_file'
            }
        }
    },
    [8] = {
        Name = "Ácido",
        Time = 30,
        MakeItem = 'hd_acid',
        Descripe = "¡Puedes usar esto para escapar!",
        Needed = {
            [1] = {
                Name = "Botella",
                Amount = 1,
                Item = 'hd_bottle'
            },
            [2] = {
                Name = "Grasa",
                Amount = 3,
                Item = 'hd_grease'
            },
            [3] = {
                Name = "Líquido sucio",
                Amount = 1,
                Item = 'hd_dliquid'
            },
            [4] = {
                Name = "Limpiador",
                Amount = 1,
                Item = 'hd_cleaner'
            },
            [5] = {
                Name = "Cuchara",
                Amount = 1,
                Item = 'hd_spoon'
            }
        }
    },
    [9] = {
        Name = "Mini martillo",
        Time = 25,
        MakeItem = 'hd_minih',
        Descripe = "¡Puedes usar esto para escapar!",
        Needed = {
            [1] = {
                Name = "Metal",
                Amount = 1,
                Item = 'hd_metal'
            },
            [2] = {
                Name = "Roca",
                Amount = 1,
                Item = 'hd_rock'
            },
            [3] = {
                Name = "Cucharón",
                Amount = 1,
                Item = 'hd_ladle'
            },
            [4] = {
                Name = "Tela",
                Amount = 1,
                Item = 'hd_cloth'
            }
        }
    },
    [10] = {
        Name = "Puñetazo de prisión",
        Time = 10,
        MakeItem = 'hd_ppunch',
        Descripe = "¡Puedes usar esto para saciar tu sed!",
        Needed = {
            [1] = {
                Name = "Líquido sucio",
                Amount = 1,
                Item = 'hd_dliquid'
            },
            [2] = {
                Name = "Sobre de sabor",
                Amount = 3,
                Item = 'hd_fpacket'
            },
            [3] = {
                Name = "Botella",
                Amount = 1,
                Item = 'hd_bottle'
            }
        }
    },
    [11] = {
        Name = "Calentador de inmersión",
        Time = 25,
        MakeItem = 'hd_iheat',
        Descripe = "¡Puedes usar esto para destilar alcohol!",
        Needed = {
            [1] = {
                Name = "Enchufe",
                Amount = 1,
                Item = 'hd_plug'
            },
            [2] = {
                Name = "Monedas sueltas",
                Amount = 2,
                Item = 'hd_schange'
            }
        }
    },
    [12] = {
        Name = "Alcohol",
        Time = 15,
        MakeItem = 'hd_booze',
        Descripe = "¡Puedes usar esto para embriagarte!",
        Needed = {
            [1] = {
                Name = "Calentador de inmersión",
                Amount = 1,
                Item = 'hd_iheat'
            },
            [2] = {
                Name = "Puñetazo de prisión",
                Amount = 1,
                Item = 'hd_ppunch'
            }
        }
    }
}


-- Configuraciones de Información (Configuraciones del Anciano)
Config.InfoPed = 'csb_rashcosvki' -- Modelo del peatón del Anciano
Config.InfoPedChangeTime = 3 -- Cuánto tiempo hasta que el anciano cambie de ubicación (en minutos)
Config.InfoPedLoc = { -- Todas las ubicaciones en las que podría estar el peatón
    [1] = {Loc = vector3(3942.23, 58.69, 22.63), Heading = 218.67},
    [2] = {Loc = vector3(3888.42, 17.82, 23.89), Heading = 35.25},
    [3] = {Loc = vector3(4092.96, 31.81, 18.76), Heading = 73.08},
    [4] = {Loc = vector3(4092.96, 31.81, 18.76), Heading = 73.08}
}
Config.InfoPedBlip = {Spawn = true, Sprite = 66, Color = 5, Size = 0.7} -- Configuraciones de todos los blips para el Anciano

Config.IMarkNum = 27 -- Número del marcador 3D del Anciano
Config.IMarkColor = {r = 227, g = 223, b = 16} -- Color del marcador 3D del Anciano
Config.IMarkSize = {x = 1.0, y = 1.0, z = 0.5} -- Tamaño del marcador 3D del Anciano

-- Configuraciones del Administrador de Trabajo
Config.JobManLoc = {Loc = vector3(3915.36, 20.52, 23.85), Heading = 357.52} -- Ubicación del peatón del administrador de trabajo
Config.JobManBlip = {Spawn = true, Sprite = 267, Color = 0, Size = 0.9} -- Blip del administrador de trabajo
Config.JobManPed = 's_m_m_prisguard_01' -- Peatón del administrador de trabajo

Config.JMMarkNum = 27 -- Número del marcador 3D del administrador de trabajo
Config.JMMarkColor = {r = 255, g = 0, b = 255} -- Color del marcador 3D del administrador de trabajo
Config.JMMarkSize = {x = 1.0, y = 1.0, z = 0.5} -- Tamaño del marcador 3D del administrador de trabajo

Config.SeeTaskMark = 5 -- Qué tan cerca debes estar para ver el marcador 3D
Config.SeeTaskText = 0.8 -- Qué tan cerca debes estar para realizar la tarea

Config.JobOptions = {
    [1] = {
        Name = "Limpiador de Duchas",
        TimeRemove = 30,
        StealChance = 3,
        StealItems = {
            [1] = {Name = "Limpiador", Item = 'hd_cleaner', Chance = 5},
            [2] = {Name = "Líquido Sucio", Item = 'hd_dliquid', Chance = 5}
        },
        Tasks = {
            [1] = {
                TaskName = "Agarrar Limpiador",
                TaskLoc = {Loc = vector3(3912.31, 40.87, 23.89), Heading = 86.84},
                Anim = {Dict = 'anim@amb@business@coc@coc_unpack_cut_left@', AnimName = 'coke_cut_v5_coccutter'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 235, g = 116, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [2] = {
                TaskName = "Limpiar Mancha",
                TaskLoc = {Loc = vector3(3907.89, 40.91, 23.89), Heading = 87.24},
                Anim = {Dict = 'amb@world_human_maid_clean@', AnimName = 'base'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 235, g = 116, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [3] = {
                TaskName = "Limpiar Mancha",
                TaskLoc = {Loc = vector3(3907.33, 39.06, 23.89), Heading = 89.68},
                Anim = {Dict = 'amb@world_human_maid_clean@', AnimName = 'base'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 235, g = 116, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            -- Continúa con las tareas restantes...
            [4] = {
                TaskName = "Limpiar Mancha",
                TaskLoc = {Loc = vector3(3907.33, 36.90, 23.89), Heading = 95.85},
                Anim = {Dict = 'amb@world_human_maid_clean@', AnimName = 'base'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 235, g = 116, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [5] = {
                TaskName = "Limpiar Mancha",
                TaskLoc = {Loc = vector3(3904.65, 35.00, 23.89), Heading = 179.27},
                Anim = {Dict = 'amb@world_human_maid_clean@', AnimName = 'base'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 235, g = 116, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [6] = {
                TaskName = "Limpiar Mancha",
                TaskLoc = {Loc = vector3(3904.18, 38.18, 23.89), Heading = 95.42},
                Anim = {Dict = 'amb@world_human_maid_clean@', AnimName = 'base'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 235, g = 116, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [7] = {
                TaskName = "Limpiar Mancha",
                TaskLoc = {Loc = vector3(3904.66, 42.30, 23.89), Heading = 357.24},
                Anim = {Dict = 'amb@world_human_maid_clean@', AnimName = 'base'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 235, g = 116, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [8] = {
                TaskName = "Limpiar Mancha",
                TaskLoc = {Loc = vector3(3906.41, 41.06, 23.89), Heading = 283.73},
                Anim = {Dict = 'amb@world_human_maid_clean@', AnimName = 'base'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 235, g = 116, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [9] = {
                TaskName = "Limpiar Mancha",
                TaskLoc = {Loc = vector3(3906.41, 39.12, 23.89), Heading = 268.37},
                Anim = {Dict = 'amb@world_human_maid_clean@', AnimName = 'base'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 235, g = 116, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [10] = {
                TaskName = "Limpiar Mancha",
                TaskLoc = {Loc = vector3(3906.39, 36.86, 23.89), Heading = 272.11},
                Anim = {Dict = 'amb@world_human_maid_clean@', AnimName = 'base'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 235, g = 116, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [11] = {
                TaskName = "Limpiar Mancha",
                TaskLoc = {Loc = vector3(3910.39, 42.27, 23.89), Heading = 359.53},
                Anim = {Dict = 'amb@world_human_maid_clean@', AnimName = 'base'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 235, g = 116, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_sponge_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [12] = {
                TaskName = "Devolver Limpiador",
                TaskLoc = {Loc = vector3(3912.87, 40.87, 23.89), Heading = 77.67},
                Anim = {Dict = 'anim@amb@business@coc@coc_unpack_cut_left@', AnimName = 'coke_cut_v5_coccutter'},
                Time = 7,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 235, g = 116, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            }
        }
    },
    [2] = {
        Name = "limpieza de ropa",
        TimeRemove = 25,
        StealChance = 3,
        StealItems = {
            [1] = {Name = "Limpiador", Item = 'hd_cleaner', Chance = 5},
            [2] = {Name = "Tela", Item = 'hd_cloth', Chance = 3},
            [3] = {Name = "Líquido sucio", Item = 'hd_dliquid', Chance = 7}
        },
        Tasks = {
            [1] = {
                TaskName = "Agarra la ropa sucia",
                TaskLoc = {Loc = vector3(1766.3508300781, 2612.4096679688, 50.549800872803), Heading = 173.91},
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
                TaskName = "Poner la ropa en la lavadora",
                TaskLoc = {Loc = vector3(1766.3508300781, 2612.4096679688, 50.549800872803), Heading = 173.91},
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
                TaskName = "Poner la ropa en la lavadora",
                TaskLoc = {Loc = vector3(1772.158203125, 2616.2888183594, 50.549766540527), Heading = 178.31},
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
                TaskName = "Poner la ropa en la lavadora",
                TaskLoc = {Loc = vector3(1770.8294677734, 2616.2634277344, 50.549770355225), Heading = 178.59},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_ld_tshirt_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [5] = {
                TaskName = "Poner la ropa en la lavadora",
                TaskLoc = {Loc = vector3(1769.4437255859, 2616.3513183594, 50.549770355225), Heading = 179.15},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [6] = {
                TaskName = "Agarra la ropa mojada",
                TaskLoc = {Loc = vector3(1766.3508300781, 2612.4096679688, 50.549800872803), Heading = 173.91},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_ld_tshirt_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [7] = {
                TaskName = "Poner la ropa mojada en la secadora.",
                TaskLoc = {Loc = vector3(1773.6488037109, 2612.642578125, 50.549781799316), Heading = 358.21},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [8] = {
                TaskName = "Agarra la ropa mojada",
                TaskLoc = {Loc = vector3(1772.158203125, 2616.2888183594, 50.549766540527), Heading = 178.31},
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
                TaskName = "Poner la ropa mojada en la secadora.",
                TaskLoc = {Loc = vector3(1772.3046875, 2612.6450195312, 50.549781799316), Heading = 358.47},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [10] = {
                TaskName = "Agarra la ropa mojada",
                TaskLoc = {Loc = vector3(1770.8294677734, 2616.2634277344, 50.549770355225), Heading = 178.59},
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
                TaskName = "Poner la ropa mojada en la secadora.",
                TaskLoc = {Loc = vector3(1770.9346923828, 2612.7666015625, 50.549781799316), Heading = 357.91},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second = 0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [12] = {
                TaskName = "Agarra la ropa mojada",
                TaskLoc = {Loc = vector3(1769.4437255859, 2616.3513183594, 50.549770355225), Heading = 179.15},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_ld_tshirt_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [13] = {
                TaskName = "Poner la ropa mojada en la secadora.",
                TaskLoc = {Loc = vector3(1769.5684814453, 2612.8989257812, 50.549781799316), Heading = 355.68},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [14] = {
                TaskName = "Coge ropa seca",
                TaskLoc = {Loc = vector3(1773.6488037109, 2612.642578125, 50.549781799316), Heading = 358.21},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_ld_tshirt_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [15] = {
                TaskName = "Coge ropa seca",
                TaskLoc = {Loc = vector3(1772.3046875, 2612.6450195312, 50.549781799316), Heading = 358.47},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_ld_tshirt_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [16] = {
                TaskName = "Coge ropa seca",
                TaskLoc = {Loc = vector3(1770.9346923828, 2612.7666015625, 50.549781799316), Heading = 357.91},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_ld_tshirt_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [17] = {
                TaskName = "Coge ropa seca",
                TaskLoc = {Loc = vector3(1769.5684814453, 2612.8989257812, 50.549781799316), Heading = 355.68},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_ld_tshirt_01', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [18] = {
                TaskName = "Guarda la ropa",
                TaskLoc = {Loc = vector3(1776.8321533203, 2619.0104980469, 50.549781799316), Heading = 358.91},
                Anim = {Dict = 'anim@amb@business@coc@coc_unpack_cut_left@', AnimName = 'coke_cut_v5_coccutter'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            }
        }
    },
    [3] = {
        Name = "Corredor de lavandería",
        TimeRemove = 10,
        StealChance = 2,
        StealItems = {
            [1] = {Name = "Botella", Item = 'hd_bottle', Chance = 1},
            [2] = {Name = "Tela", Item = 'hd_cloth', Chance = 6},
        },
        Tasks = {
            [1] = {
                TaskName = "Agarra la ropa sucia",
                TaskLoc = {Loc = vector3(1765.7221679688, 2589.353515625, 45.797821044922), Heading = 225.55},
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
                TaskName = "Dejar la ropa sucia",
                TaskLoc = {Loc = vector3(1766.3508300781, 2612.4096679688, 50.549800872803), Heading = 173.91},
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
                TaskName = "Agarra la ropa sucia",
                TaskLoc = {Loc = vector3(1762.8428955078, 2591.8645019531, 45.797821044922), Heading = 86.71},
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
                TaskName = "Dejar la ropa sucia",
                TaskLoc = {Loc = vector3(1766.3508300781, 2612.4096679688, 50.549800872803), Heading = 173.91},
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
                TaskName = "Agarra la ropa sucia",
                TaskLoc = {Loc = vector3(1780.9899902344, 2616.197265625, 50.549968719482), Heading = 14.72},
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
                TaskName = "Dejar la ropa sucia",
                TaskLoc = {Loc = vector3(1766.3508300781, 2612.4096679688, 50.549800872803), Heading = 173.91},
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
                TaskName = "Agarra la ropa sucia",
                TaskLoc = {Loc = vector3(1783.6166992188, 2610.7373046875, 50.550022125244), Heading = 264.04},
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
                TaskName = "Dejar la ropa sucia",
                TaskLoc = {Loc = vector3(1766.3508300781, 2612.4096679688, 50.549800872803), Heading = 173.91},
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
        Name = "Cocinero",
        TimeRemove = 25,
        StealChance = 4,
        StealItems = {
            [1] = {Name = "Botella", Item = 'hd_bottle', Chance = 2},
            [2] = {Name = "Grasa", Item = 'hd_grease', Chance = 5},
            [3] = {Name = "Líquido sucio", Item = 'hd_dliquid', Chance = 5},
            [4] = {Name = "Cuchara", Item = 'hd_spoon', Chance = 8},
            [5] = {Name = "Cucharón", Item = 'hd_ladle', Chance = 7},
            [6] = {Name = "Sobre de sabor", Item = 'hd_fpacket', Chance = 10}
        },
        Tasks = {
            [1] = {
                TaskName = "Agarrar sartén",
                TaskLoc = {Loc = vector3(1778.3149414062, 2593.6015625, 45.797836303711), Heading = 202.38},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 229, g = 235, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_copper_pan', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [2] = {
                TaskName = "Iniciar cocina",
                TaskLoc = {Loc = vector3(1777.9334716797, 2597.5095214844, 45.797836303711), Heading = 273.88},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 229, g = 235, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [3] = {
                TaskName = "Agarra comida",
                TaskLoc = {Loc = vector3(1776.4860839844, 2599.3669433594, 45.797836303711), Heading = 355.15},
                Anim = {Dict = 'mp_arresting', AnimName = 'a_uncuff'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 229, g = 235, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'ng_proc_food_ornge1a', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [4] = {
                TaskName = "Cocinar los alimentos",
                TaskLoc = {Loc = vector3(1777.9334716797, 2597.5095214844, 45.797836303711), Heading = 273.88},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 20,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 229, g = 235, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [5] = {
                TaskName = "Cajas de agarre",
                TaskLoc = {Loc = vector3(1782.3448486328, 2594.396484375, 45.797836303711), Heading = 273.6},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 229, g = 235, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'ng_proc_food_burg02a', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [6] = {
                TaskName = "Establecer cuadros hacia abajo",
                TaskLoc = {Loc = vector3(1779.2886962891, 2593.552734375, 45.797836303711), Heading = 180.42},
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
                TaskName = "Coge comida cocinada",
                TaskLoc = {Loc = vector3(1777.8962402344, 2597.3732910156, 45.797821044922), Heading = 267.45},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 229, g = 235, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_copper_pan', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [8] = {
                TaskName = "Coloque los alimentos cocinados",
                TaskLoc = {Loc = vector3(1778.5102539062, 2592.2087402344, 45.797821044922), Heading = 359.12},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 229, g = 235, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [9] = {
                TaskName = "Caja de comida",
                TaskLoc = {Loc = vector3(1779.1472167969, 2593.5998535156, 45.797821044922), Heading = 184.67},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 229, g = 235, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'ng_proc_food_burg02a', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [10] = {
                TaskName = "Plato De Comida",
                TaskLoc = {Loc = vector3(1779.4445800781, 2592.0959472656, 45.797821044922), Heading = 355.66},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 229, g = 235, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = true, Prop = 'prop_food_bs_tray_02', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [11] = {
                TaskName = "Repartir comida",
                TaskLoc = {Loc = vector3(1779.4532470703, 2591.4274902344, 45.797821044922), Heading = 176.83},
                Anim = {Dict = 'anim@amb@clubhouse@bar@drink@idle_a', AnimName = 'idle_a_bartender'},
                Time = 10,
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
        Name = "Limpiador de basura",
        TimeRemove = 25,
        StealChance = 3,
        StealItems = {
            [1] = {Name = "Botella", Item = 'hd_bottle', Chance = 2},
            [2] = {Name = "Roca", Item = 'hd_rock', Chance = 5},
            [3] = {Name = "Cucharón roto", Item = 'hd_bladle', Chance = 3},
            [4] = {Name = "Metal", Item = 'hd_metal', Chance = 4},
            [5] = {Name = "Cuchara rota", Item = 'hd_jspoon', Chance = 6},
            [6] = {Name = "Monedas sueltas", Item = 'hd_schange', Chance = 6},
            [7] = {Name = "Enchufe", Item = 'hd_plug', Chance = 4}
        },
        Tasks = {
            [1] = {
                TaskName = "Agarra la basura",
                TaskLoc = {Loc = vector3(1704.4982910156, 2551.7905273438, 45.564895629883), Heading = 91.44},
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
                TaskName = "Tirar basura",
                TaskLoc = {Loc = vector3(1622.4766845703, 2615.7399902344, 45.564853668213), Heading = 192.76},
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
                TaskName = "Agarra la basura",
                TaskLoc = {Loc = vector3(1700.7912597656, 2555.5249023438, 45.56489944458), Heading = 188.0},
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
                TaskName = "Tirar basura",
                TaskLoc = {Loc = vector3(1622.4766845703, 2615.7399902344, 45.564853668213), Heading = 192.76},
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
                TaskName = "Agarra la basura",
                TaskLoc = {Loc = vector3(1719.0423583984, 2501.5693359375, 45.564853668213), Heading = 275.89},
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
                TaskName = "Tirar basura",
                TaskLoc = {Loc = vector3(1622.4766845703, 2615.7399902344, 45.564853668213), Heading = 192.76},
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
                TaskName = "Agarra la basura",
                TaskLoc = {Loc = vector3(1719.6976318359, 2503.8447265625, 45.564853668213), Heading = 274.05},
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
                TaskName = "Tirar basura",
                TaskLoc = {Loc = vector3(1622.4766845703, 2615.7399902344, 45.564853668213), Heading = 192.76},
                Anim = {Dict = 'amb@prop_human_bum_bin@base', AnimName = 'base'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [9] = {
                TaskName = "Coge bolsas vacías",
                TaskLoc = {Loc = vector3(1778.1514892578, 2617.6296386719, 50.549797058105), Heading = 299.56},
                Anim = {Dict = 'amb@prop_human_bum_bin@base', AnimName = 'base'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [10] = {
                TaskName = "Poner la bolsa de basura",
                TaskLoc = {Loc = vector3(1704.4982910156, 2551.7905273438, 45.564895629883), Heading = 91.44},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [11] = {
                TaskName = "Poner la bolsa de basura",
                TaskLoc = {Loc = vector3(1700.7912597656, 2555.5249023438, 45.56489944458), Heading = 188.0},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [12] = {
                TaskName = "Poner la bolsa de basura",
                TaskLoc = {Loc = vector3(1719.0423583984, 2501.5693359375, 45.564853668213), Heading = 275.89},
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}},
                CarryItem = {Attach = false, Prop = 'nil', Offsets = {First = 0.0, Second =  0.0, Third = -0.01, Four = 90.0, Five = 0.0, Six = 0.0}}
            },
            [13] = {
                TaskName = "Poner la bolsa de basura",
                TaskLoc = {Loc = vector3(1719.6976318359, 2503.8447265625, 45.564853668213), Heading = 274.05},
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

--Configuraciones de uniformes
Config.Uniforms = { --Ropa de los uniformes
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

--Configuraciones de celdas
Config.Cells = { --Todas las celdas de la prisión
    [1] = {
        SpawnLoc = {Loc = vector3(3909.2427, 31.8089, 23.8882), Heading = 173.5104}, --Ubicación de aparición (normalmente en el centro de la celda)
        InvLoc = {Loc = vector3(3910.2151, 31.9358, 23.8882), Heading = 267.5397}, --Ubicación del inventario o de la cama
        BreakLoc = {Loc = vector3(3909.5969, 33.7807, 23.8882), Heading = 1.6232}, --Ubicación de escape
        ExitLoc = {Loc = vector3(3910.5522, 43.4814, 21.6951), Heading = 3.5825} --Salida después de arrastrarse durante el escape (normalmente fuera del edificio)
    },
    [2] = {
        SpawnLoc = {Loc = vector3(3905.59, 32.29, 23.89), Heading = 173.82},
        InvLoc = {Loc = vector3(3906.58, 32.12, 24.42), Heading = 266.27},
        BreakLoc = {Loc = vector3(3905.87, 34.00, 23.89), Heading = 357.88},
        ExitLoc = {Loc = vector3(3905.82, 43.96, 22.02), Heading = 351.74}
    },
    [3] = {
        SpawnLoc = {Loc = vector3(3898.63, 33.03, 23.60), Heading = 173.58},
        InvLoc = {Loc = vector3(3899.51, 32.86, 23.60), Heading = 264.12},
        BreakLoc = {Loc = vector3(3898.89, 34.64, 23.60), Heading = 358.75},
        ExitLoc = {Loc = vector3(3900.76, 44.38, 22.90), Heading = 353.55}
    },
    [4] = {
        SpawnLoc = {Loc = vector3(3895.13, 33.19, 24.04), Heading = 175.03},
        InvLoc = {Loc = vector3(3896.02, 33.12, 24.04), Heading = 266.10},
        BreakLoc = {Loc = vector3(3895.38, 35.07, 24.04), Heading = 358.69},
        ExitLoc = {Loc = vector3(3895.19, 45.06, 21.20), Heading = 4.17}
    },
    [5] = {
        SpawnLoc = {Loc = vector3(3908.43, 18.41, 23.58), Heading = 352.32},
        InvLoc = {Loc = vector3(3907.72, 18.75, 23.58), Heading = 94.31},
        BreakLoc = {Loc = vector3(3909.28, 16.38, 23.58), Heading = 222.01},
        ExitLoc = {Loc = vector3(3908.79, 12.95, 20.68), Heading = 178.62}
    },
    [6] = {
        SpawnLoc = {Loc = vector3(3904.74, 18.42, 23.70), Heading = 355.67},
        InvLoc = {Loc = vector3(3905.48, 18.31, 23.70), Heading = 265.30},
        BreakLoc = {Loc = vector3(3904.72, 16.55, 23.70), Heading = 176.87},
        ExitLoc = {Loc = vector3(3904.47, 13.26, 20.62), Heading = 178.18}
    },
    [7] = {
        SpawnLoc = {Loc = vector3(3897.15, 19.21, 23.64), Heading = 352.13},
        InvLoc = {Loc = vector3(3898.59, 18.83, 23.64), Heading = 264.77},
        BreakLoc = {Loc = vector3(3896.73, 17.49, 23.64), Heading = 173.97},
        ExitLoc = {Loc = vector3(3894.73, 14.08, 21.25), Heading = 170.85}
    },
    [8] = {
        SpawnLoc = {Loc = vector3(3893.88, 19.76, 23.96), Heading = 353.39},
        InvLoc = {Loc = vector3(3895.17, 19.39, 23.96), Heading = 264.53},
        BreakLoc = {Loc = vector3(3893.84, 17.60, 23.96), Heading = 177.29},
        ExitLoc = {Loc = vector3(3890.30, 14.71, 21.31), Heading = 175.79}
    },
    [9] = {
        SpawnLoc = {Loc = vector3(3890.54, 20.02, 24.21), Heading = 353.68},
        InvLoc = {Loc = vector3(3891.37, 19.61, 23.96), Heading = 264.65},
        BreakLoc = {Loc = vector3(3890.24, 17.94, 23.96), Heading = 174.23},
        ExitLoc = {Loc = vector3(3871.98, 16.15, 20.05), Heading = 176.03}
    },
    -- [10] = {
    --     SpawnLoc = {Loc = vector3(1789.3742675781, 2597.7961425781, 50.749686431885), Heading = 85.54},
    --     InvLoc = {Loc = vector3(1789.505859375, 2597.0419921875, 50.549674987793), Heading = 182.1},
    --     BreakLoc = {Loc = vector3(1791.0850830078, 2598.8977050781, 50.549648284912), Heading = 312.08},
    --     ExitLoc = {Loc = vector3(1793.4119873047, 2597.4797363281, 50.549686431885), Heading = 271.54}
    -- },
    -- [11] = {
    --     SpawnLoc = {Loc = vector3(1789.5588378906, 2593.9780273438, 50.749682617188), Heading = 95.18},
    --     InvLoc = {Loc = vector3(1789.4688720703, 2593.1052246094, 50.549674987793), Heading = 180.26},
    --     BreakLoc = {Loc = vector3(1791.0808105469, 2592.4436035156, 50.549674987793), Heading = 266.7},
    --     ExitLoc = {Loc = vector3(1792.5063476562, 2590.3471679688, 50.549644470215), Heading = 259.79}
    -- },
    -- [12] = {
    --     SpawnLoc = {Loc = vector3(1789.5648193359, 2589.9360351562, 50.749682617188), Heading = 90.52},
    --     InvLoc = {Loc = vector3(1789.5354003906, 2589.1411132812, 50.549674987793), Heading = 181.37},
    --     BreakLoc = {Loc = vector3(1791.0660400391, 2589.3720703125, 50.549682617188), Heading = 265.44},
    --     ExitLoc = {Loc = vector3(1792.3619384766, 2589.2690429688, 50.549682617188), Heading = 280.44}
    -- },
    -- [13] = {
    --     SpawnLoc = {Loc = vector3(1789.7143554688, 2586.0202636719, 50.74967880249), Heading = 86.06},
    --     InvLoc = {Loc = vector3(1789.5093994141, 2585.2253417969, 50.549674987793), Heading = 180.85},
    --     BreakLoc = {Loc = vector3(1791.0834960938, 2586.611328125, 50.54967880249), Heading = 272.62},
    --     ExitLoc = {Loc = vector3(1792.3813476562, 2586.5346679688, 50.54967880249), Heading = 266.62}
    -- },
    -- [14] = {
    --     SpawnLoc = {Loc = vector3(1789.5427246094, 2582.0017089844, 50.74967880249), Heading = 84.61},
    --     InvLoc = {Loc = vector3(1789.4792480469, 2581.4289550781, 50.549667358398), Heading = 181.04},
    --     BreakLoc = {Loc = vector3(1791.0854492188, 2583.099609375, 50.549682617188), Heading = 299.56},
    --     ExitLoc = {Loc = vector3(1792.3929443359, 2582.7661132812, 50.549682617188), Heading = 267.4}
    -- },
    -- [15] = {
    --     SpawnLoc = {Loc = vector3(1789.6608886719, 2578.1564941406, 50.749682617188), Heading = 92.28},
    --     InvLoc = {Loc = vector3(1789.5045166016, 2577.3391113281, 50.549667358398), Heading = 181.04},
    --     BreakLoc = {Loc = vector3(1791.0764160156, 2577.482421875, 50.54967880249), Heading = 299.78},
    --     ExitLoc = {Loc = vector3(1792.3698730469, 2577.6137695312, 50.54967880249), Heading = 248.78}
    -- },
    -- [16] = {
    --     SpawnLoc = {Loc = vector3(1789.6860351562, 2574.1623535156, 50.74967880249), Heading = 85.52},
    --     InvLoc = {Loc = vector3(1789.5131835938, 2573.2880859375, 50.549663543701), Heading = 181.66},
    --     BreakLoc = {Loc = vector3(1791.0576171875, 2572.830078125, 50.54967880249), Heading = 252.54},
    --     ExitLoc = {Loc = vector3(1792.3802490234, 2573.1860351562, 50.549674987793), Heading = 267.48}
    -- },
    -- [17] = {
    --     SpawnLoc = {Loc = vector3(1785.9571533203, 2568.546875, 50.749640655518), Heading = 354.54},
    --     InvLoc = {Loc = vector3(1785.1077880859, 2568.3430175781, 50.549663543701), Heading = 94.24},
    --     BreakLoc = {Loc = vector3(1786.5700683594, 2567.3422851562, 50.549648284912), Heading = 170.67},
    --     ExitLoc = {Loc = vector3(1786.3596191406, 2566.0595703125, 50.655014038086), Heading = 170.67}
    -- },
    -- [18] = {
    --     SpawnLoc = {Loc = vector3(1781.9460449219, 2568.5207519531, 50.749648284912), Heading = 354.54},
    --     InvLoc = {Loc = vector3(1781.3151855469, 2568.31640625, 50.549663543701), Heading = 90.14},
    --     BreakLoc = {Loc = vector3(1781.2250976562, 2567.3444824219, 50.549633026123), Heading = 170.54},
    --     ExitLoc = {Loc = vector3(1781.01171875, 2566.0622558594, 50.653945922852), Heading = 170.54}
    -- },
    -- [19] = {
    --     SpawnLoc = {Loc = vector3(1777.9897460938, 2568.4787597656, 50.749674987793), Heading = 353.39},
    --     InvLoc = {Loc = vector3(1777.3060302734, 2568.3034667969, 50.549674987793), Heading = 94.3},
    --     BreakLoc = {Loc = vector3(1778.8114013672, 2567.2932128906, 50.549686431885), Heading = 182.02},
    --     ExitLoc = {Loc = vector3(1778.8533935547, 2566.0939941406, 50.654499053955), Heading = 182.02}
    -- },
    -- [20] = {
    --     SpawnLoc = {Loc = vector3(1774.1789550781, 2568.4877929688, 50.749644470215), Heading = 359.2},
    --     InvLoc = {Loc = vector3(1773.4216308594, 2568.2927246094, 50.549652099609), Heading = 94.1},
    --     BreakLoc = {Loc = vector3(1773.6292724609, 2567.3210449219, 50.549644470215), Heading = 176.38},
    --     ExitLoc = {Loc = vector3(1773.5793457031, 2566.2719726562, 50.549644470215), Heading = 173.38}
    -- },
    -- [21] = {
    --     SpawnLoc = {Loc = vector3(1769.3565673828, 2573.7731933594, 50.749644470215), Heading = 269.33},
    --     InvLoc = {Loc = vector3(1769.6387939453, 2574.7053222656, 50.549652099609), Heading = 0.56},
    --     BreakLoc = {Loc = vector3(1768.052734375, 2572.8659667969, 50.549644470215), Heading = 95.46},
    --     ExitLoc = {Loc = vector3(1762.2921142578, 2568.4255371094, 55.439956665039), Heading = 96.7}
    -- },
    -- [22] = {
    --     SpawnLoc = {Loc = vector3(1769.8432617188, 2577.8327636719, 50.749644470215), Heading = 268.72},
    --     InvLoc = {Loc = vector3(1769.6157226562, 2578.6518554688, 50.549652099609), Heading = 3.09},
    --     BreakLoc = {Loc = vector3(1768.0277099609, 2579.1931152344, 50.549644470215), Heading = 90.71},
    --     ExitLoc = {Loc = vector3(1759.328125, 2579.0798339844, 55.447151184082), Heading = 90.71}
    -- },
    -- [23] = {
    --     SpawnLoc = {Loc = vector3(1769.6654052734, 2581.6948242188, 50.749640655518), Heading = 267.45},
    --     InvLoc = {Loc = vector3(1769.5592041016, 2582.5307617188, 50.549652099609), Heading = 3.62},
    --     BreakLoc = {Loc = vector3(1767.9350585938, 2581.25, 50.549640655518), Heading = 66.72},
    --     ExitLoc = {Loc = vector3(1759.5678710938, 2580.3923339844, 55.437309265137), Heading = 96.67}
    -- },
    -- [24] = {
    --     SpawnLoc = {Loc = vector3(1769.5938720703, 2585.609375, 50.749644470215), Heading = 268.73},
    --     InvLoc = {Loc = vector3(1769.5998535156, 2586.4814453125, 50.549652099609), Heading = 359.06},
    --     BreakLoc = {Loc = vector3(1767.9349365234, 2584.5981445312, 50.549644470215), Heading = 92.05},
    --     ExitLoc = {Loc = vector3(1759.5157470703, 2585.5126953125, 55.452182769775), Heading = 98.75}
    -- },
    -- [25] = {
    --     SpawnLoc = {Loc = vector3(1769.5305175781, 2589.7097167969, 50.749686431885), Heading = 267.88},
    --     InvLoc = {Loc = vector3(1769.5876464844, 2590.4455566406, 50.549652099609), Heading = 359.67},
    --     BreakLoc = {Loc = vector3(1768.0327148438, 2589.103515625, 50.549686431885), Heading = 88.46},
    --     ExitLoc = {Loc = vector3(1759.3814697266, 2589.8505859375, 55.438919067383), Heading = 92.57}
    -- },
    -- [26] = {
    --     SpawnLoc = {Loc = vector3(1769.7008056641, 2593.5534667969, 50.749644470215), Heading = 269.47},
    --     InvLoc = {Loc = vector3(1769.5700683594, 2594.3120117188, 50.549652099609), Heading = 0.81},
    --     BreakLoc = {Loc = vector3(1768.0305175781, 2594.9470214844, 50.549644470215), Heading = 83.24},
    --     ExitLoc = {Loc = vector3(1759.5305175781, 2594.8474121094, 55.43803024292), Heading = 98.24}
    -- },
    -- [27] = {
    --     SpawnLoc = {Loc = vector3(1769.7208251953, 2597.4226074219, 50.749644470215), Heading = 266.67},
    --     InvLoc = {Loc = vector3(1769.6168212891, 2598.3002929688, 50.549652099609), Heading = 359.83},
    --     BreakLoc = {Loc = vector3(1768.0040283203, 2598.1389160156, 50.549644470215), Heading = 89.31},
    --     ExitLoc = {Loc = vector3(1759.4516601562, 2598.236328125, 55.44762802124), Heading = 89.31}
    -- },
    -- [28] = {
    --     SpawnLoc = {Loc = vector3(1773.2811279297, 2601.6760253906, 50.749663543701), Heading = 177.11},
    --     InvLoc = {Loc = vector3(1774.2319335938, 2601.6437988281, 50.549652099609), Heading = 271.94},
    --     BreakLoc = {Loc = vector3(1772.8643798828, 2603.2199707031, 50.549663543701), Heading = 89.31},
    --     ExitLoc = {Loc = vector3(1771.9135742188, 2621.5512695312, 55.45592880249), Heading = 345.73}
    -- }
}

--Configuraciones de aislamiento
Config.Solitary = true --Si quieres que haya aislamiento

Config.Sol4Run = true --Si quieres enviar a aislamiento a quienes escapen sin usar el recurso de prisión (por ejemplo, usando emotes para atravesar vallas y otros obstáculos)
Config.SolRunTime = 1 --Tiempo en minutos para la opción anterior

Config.FailBreakToSol = true --Si quieres enviar a aislamiento a quienes no escapen a tiempo
Config.SolBreakTime = 1 --Tiempo en minutos para la opción anterior

Config.Sol4Lock = false --Si quieres enviar a aislamiento a quienes intenten salir de su celda durante el bloqueo
Config.SolLockTime = 1 --Tiempo en minutos para la opción anterior

Config.Sol4Kill = true --Si quieres enviar a aislamiento a quienes maten a alguien
Config.SolKillTime = 1 --Tiempo en minutos para la opción anterior

Config.SolCells = { --Todas las ubicaciones de aislamiento
    [1] = {Loc = vector3(3909.3259, 32.1250, 27.4285), Heading = 173.8917},
    -- [2] = {Loc = vector3(1765.9827880859, 2594.2705078125, 50.54963684082), Heading = 93.12},
    -- [3] = {Loc = vector3(1765.9401855469, 2591.3493652344, 50.549640655518), Heading = 89.13},
    -- [4] = {Loc = vector3(1765.7937011719, 2588.3737792969, 50.549644470215), Heading = 93.71},
    -- [5] = {Loc = vector3(1762.1220703125, 2588.2312011719, 50.549640655518), Heading = 271.49},
    -- [6] = {Loc = vector3(1762.0230712891, 2591.0876464844, 50.549640655518), Heading = 269.32},
    -- [7] = {Loc = vector3(1762.1560058594, 2594.0744628906, 50.549644470215), Heading = 268.63},
    -- [8] = {Loc = vector3(1761.8892822266, 2597.021484375, 50.549640655518), Heading = 278.27}
}

--Configuraciones de reanimación
Config.Hospital = true --Si quieres que haya hospital
Config.DoctorPed = 's_m_m_doctor_01' --Personaje médico del hospital
Config.CheckUpTime = 10 --Tiempo necesario para revisar a un prisionero (en segundos)
Config.BedLocs = {
    [1] = {
        SpawnLoc = {Loc = vector3(1777.4617919922, 2565.4919433594, 46.722312927246), Heading = 268.2}, --Ubicación de aparición del médico
        DoctorSpawn = {Loc = vector3(1777.5787353516, 2555.0952148438, 45.797794342041), Heading = 189.93}, --Ubicación de aparición del médico
        DocCheck = {Loc = vector3(1779.1821289062, 2564.9467773438, 45.797836303711), Heading = 65.82}, --Ubicación a la que camina el médico para revisar
        DocWalkTime = 7 --Tiempo que debe tardar el médico en llegar (en segundos)
    },
    -- [2] = {
    --     SpawnLoc = {Loc = vector3(1777.5457763672, 2563.3625488281, 46.722332000732), Heading = 267.57},
    --     DoctorSpawn = {Loc = vector3(1777.5787353516, 2555.0952148438, 45.797794342041), Heading = 189.93},
    --     DocCheck = {Loc = vector3(1779.0882568359, 2563.4348144531, 45.797836303711), Heading = 89.79},
    --     DocWalkTime = 6
    -- },
    -- [3] = {
    --     SpawnLoc = {Loc = vector3(1777.6226806641, 2561.3317871094, 46.722328186035), Heading = 269.24},
    --     DoctorSpawn = {Loc = vector3(1777.5787353516, 2555.0952148438, 45.797794342041), Heading = 189.93},
    --     DocCheck = {Loc = vector3(1779.2280273438, 2561.4267578125, 45.797836303711), Heading = 90.0},
    --     DocWalkTime = 5
    -- },
    -- [4] = {
    --     SpawnLoc = {Loc = vector3(1777.57421875, 2558.9553222656, 46.722305297852), Heading = 267.91},
    --     DoctorSpawn = {Loc = vector3(1777.5787353516, 2555.0952148438, 45.797794342041), Heading = 189.93},
    --     DocCheck = {Loc = vector3(1779.1295166016, 2559.0458984375, 45.797824859619), Heading = 87.48},
    --     DocWalkTime = 5
    -- },
    -- [5] = {
    --     SpawnLoc = {Loc = vector3(1781.6727294922, 2565.5573730469, 46.722312927246), Heading = 84.24},
    --     DoctorSpawn = {Loc = vector3(1777.5787353516, 2555.0952148438, 45.797794342041), Heading = 189.93},
    --     DocCheck = {Loc = vector3(1780.111328125, 2564.7570800781, 45.797824859619), Heading = 292.52},
    --     DocWalkTime = 7
    -- },
    -- [6] = {
    --     SpawnLoc = {Loc = vector3(1781.6551513672, 2563.4787597656, 46.722332000732), Heading = 88.82},
    --     DoctorSpawn = {Loc = vector3(1777.5787353516, 2555.0952148438, 45.797794342041), Heading = 189.93},
    --     DocCheck = {Loc = vector3(1780.013671875, 2563.4584960938, 45.797824859619), Heading = 270.36},
    --     DocWalkTime = 6
    -- },
    -- [7] = {
    --     SpawnLoc = {Loc = vector3(1781.6934814453, 2561.5017089844, 46.722312927246), Heading = 90.87},
    --     DoctorSpawn = {Loc = vector3(1777.5787353516, 2555.0952148438, 45.797794342041), Heading = 189.93},
    --     DocCheck = {Loc = vector3(1780.1590576172, 2561.4636230469, 45.797824859619), Heading = 268.96},
    --     DocWalkTime = 6
    -- }
}

--Configuraciones de escape
Config.Breakout = true --Si los prisioneros pueden escapar de la prisión
Config.BreakHole = 2 --Cantidad de excavaciones exitosas necesarias

Config.CrawlTime = 15 --Tiempo necesario para atravesar la pared arrastrándose (en segundos)
Config.BreakoutTime = 120  --Tiempo disponible para escapar antes de ser atrapado (en segundos)

Config.BreakMarkNum = 22 --Número del marcador de escape
Config.BreakMarkColor = {r = 255, g = 255, b = 255} --Color del marcador de escape
Config.BreakMarkSize = {x = 0.5, y = 0.5, z = 0.5} --Tamaño del marcador de escape

Config.SeeBreakDist = 15 --Distancia necesaria para ver los marcadores
Config.BreakTextDist = 1 --Distancia necesaria para usarlo
Config.BreakBlips = {Spawn = true, Sprite = 186, Color = 49, Size = 0.5} --Indicadores de todas las ubicaciones de escape y corte

Config.BreakLocs = { --Todas las ubicaciones de corte y excavación del escape (StartLoc es donde se realiza la animación y aparece el marcador; ExitLoc es donde se teletransporta al jugador; ExitFence solo es true en la última salida antes de abandonar la prisión)
    [1] = {StartLoc = {Loc = vector3(3909.3064, 32.0933, 23.8882), Heading = 175.1696}, ExitLoc = {Loc = vector3(3898.6121, 44.5316, 22.2277), Heading = 36.8051}, ExitFence = false},
    -- [2] = {StartLoc = {Loc = vector3(1809.7244873047, 2508.5112304688, 45.457614898682), Heading = 283.54}, ExitLoc = {Loc = vector3(1811.3291015625, 2508.8952636719, 45.457614898682), Heading = 283.48}, ExitFence = false},
    -- [3] = {StartLoc = {Loc = vector3(1790.8776855469, 2457.107421875, 45.479621887207), Heading = 234.54}, ExitLoc = {Loc = vector3(1792.2528076172, 2456.1962890625, 45.479621887207), Heading = 287.84}, ExitFence = false},
    -- [4] = {StartLoc = {Loc = vector3(1775.9188232422, 2441.3542480469, 45.439235687256), Heading = 233.33}, ExitLoc = {Loc = vector3(1777.6038818359, 2440.0998535156, 45.439235687256), Heading = 283.33}, ExitFence = false},
    -- [5] = {StartLoc = {Loc = vector3(1724.5666503906, 2417.2282714844, 45.438968658447), Heading = 190.83}, ExitLoc = {Loc = vector3(1724.9614257812, 2415.1672363281, 45.438968658447), Heading = 190.83}, ExitFence = false},
    -- [6] = {StartLoc = {Loc = vector3(1691.9315185547, 2412.2934570312, 45.428443908691), Heading = 186.27}, ExitLoc = {Loc = vector3(1692.1114501953, 2410.6525878906, 45.428447723389), Heading = 186.27}, ExitFence = false},
    -- [7] = {StartLoc = {Loc = vector3(1624.4016113281, 2428.8767089844, 45.434959411621), Heading = 155.76}, ExitLoc = {Loc = vector3(1623.6633300781, 2427.2360839844, 45.433925628662), Heading = 155.76}, ExitFence = false},
    -- [8] = {StartLoc = {Loc = vector3(1580.7204589844, 2456.4575195312, 45.453197479248), Heading = 150.39}, ExitLoc = {Loc = vector3(1579.8312988281, 2454.8930664062, 45.451251983643), Heading = 150.39}, ExitFence = false},
    -- [9] = {StartLoc = {Loc = vector3(1551.0321044922, 2507.4912109375, 45.442741394043), Heading = 102.38}, ExitLoc = {Loc = vector3(1548.9813232422, 2507.0400390625, 45.442741394043), Heading = 102.38}, ExitFence = false},
    -- [10] = {StartLoc = {Loc = vector3(1549.2059326172, 2553.435546875, 45.448348999023), Heading = 94.47}, ExitLoc = {Loc = vector3(1547.4114990234, 2553.294921875, 45.448348999023), Heading = 94.47}, ExitFence = false},
    -- [11] = {StartLoc = {Loc = vector3(1555.7008056641, 2609.8635253906, 45.43217086792), Heading = 66.16}, ExitLoc = {Loc = vector3(1553.7633056641, 2610.4404296875, 45.431995391846), Heading = 74.34}, ExitFence = false},
    -- [12] = {StartLoc = {Loc = vector3(1570.4975585938, 2649.8615722656, 45.430034637451), Heading = 77.84}, ExitLoc = {Loc = vector3(1568.4450683594, 2650.3024902344, 45.430034637451), Heading = 77.84}, ExitFence = false},
    -- [13] = {StartLoc = {Loc = vector3(1598.7795410156, 2692.2275390625, 45.414165496826), Heading = 54.58}, ExitLoc = {Loc = vector3(1597.4354248047, 2693.18359375, 45.414165496826), Heading = 54.58}, ExitFence = false},
    -- [14] = {StartLoc = {Loc = vector3(1635.0993652344, 2727.2709960938, 45.431541442871), Heading = 57.41}, ExitLoc = {Loc = vector3(1633.7095947266, 2728.1599121094, 45.431541442871), Heading = 57.41}, ExitFence = false},
    -- [15] = {StartLoc = {Loc = vector3(1680.9978027344, 2748.4436035156, 45.513088226318), Heading = 14.11}, ExitLoc = {Loc = vector3(1680.5450439453, 2750.4870605469, 45.543704986572), Heading = 355.39}, ExitFence = false},
    -- [16] = {StartLoc = {Loc = vector3(1745.5191650391, 2750.9538574219, 45.542251586914), Heading = 2.11}, ExitLoc = {Loc = vector3(1745.4588623047, 2752.6025390625, 45.542247772217), Heading = 2.11}, ExitFence = false},
    -- [17] = {StartLoc = {Loc = vector3(1791.0699462891, 2734.2351074219, 45.404987335205), Heading = 322.09}, ExitLoc = {Loc = vector3(1792.2680664062, 2735.7744140625, 45.404987335205), Heading = 322.09}, ExitFence = false},
    -- [18] = {StartLoc = {Loc = vector3(1817.7440185547, 2712.5649414062, 45.476692199707), Heading = 324.15}, ExitLoc = {Loc = vector3(1819.060546875, 2714.388671875, 45.476692199707), Heading = 324.15}, ExitFence = false},
    -- [19] = {StartLoc = {Loc = vector3(1828.8676757812, 2674.0642089844, 45.486404418945), Heading = 256.23}, ExitLoc = {Loc = vector3(1831.4047851562, 2674.646484375, 45.354648590088), Heading = 258.15}, ExitFence = false},
    -- [20] = {StartLoc = {Loc = vector3(1818.7711181641, 2645.3774414062, 45.348693847656), Heading = 260.1}, ExitLoc = {Loc = vector3(1820.6928710938, 2645.041015625, 45.348693847656), Heading = 260.1}, ExitFence = false},
    -- [21] = {StartLoc = {Loc = vector3(1772.18359375, 2535.2783203125, 45.564914703369), Heading = 242.16}, ExitLoc = {Loc = vector3(1773.2451171875, 2534.7177734375, 45.564914703369), Heading = 242.16}, ExitFence = false},
    -- [22] = {StartLoc = {Loc = vector3(1723.4884033203, 2489.8776855469, 45.564838409424), Heading = 186.26}, ExitLoc = {Loc = vector3(1723.6029052734, 2488.8334960938, 45.564838409424), Heading = 186.26}, ExitFence = false},
    -- [23] = {StartLoc = {Loc = vector3(1662.0093994141, 2487.1945800781, 45.564903259277), Heading = 142.98}, ExitLoc = {Loc = vector3(1661.3770751953, 2486.35546875, 45.564903259277), Heading = 142.98}, ExitFence = false},
    -- [24] = {StartLoc = {Loc = vector3(1682.1802978516, 2679.4465332031, 45.564884185791), Heading = 18.41}, ExitLoc = {Loc = vector3(1681.7540283203, 2680.7275390625, 45.564884185791), Heading = 18.41}, ExitFence = false},
    -- [25] = {StartLoc = {Loc = vector3(1739.771484375, 2678.1396484375, 45.564884185791), Heading = 6.5}, ExitLoc = {Loc = vector3(1739.6357421875, 2679.3310546875, 45.564884185791), Heading = 6.5}, ExitFence = false},
    -- [26] = {StartLoc = {Loc = vector3(1816.478515625, 2527.4321289062, 43.414501190186), Heading = 285.83}, ExitLoc = {Loc = vector3(1817.9105224609, 2527.8410644531, 45.671981811523), Heading = 285.83}, ExitFence = true},
    -- [27] = {StartLoc = {Loc = vector3(1791.41796875, 2442.8901367188, 43.414661407471), Heading = 237.53}, ExitLoc = {Loc = vector3(1793.2797851562, 2442.3059082031, 45.378692626953), Heading = 234.75}, ExitFence = true},
    -- [28] = {StartLoc = {Loc = vector3(1706.1419677734, 2404.3161621094, 43.414566040039), Heading = 193.26}, ExitLoc = {Loc = vector3(1706.5561523438, 2402.623046875, 45.418384552002), Heading = 195.3}, ExitFence = true},
    -- [29] = {StartLoc = {Loc = vector3(1601.6594238281, 2431.8190917969, 43.414520263672), Heading = 151.75}, ExitLoc = {Loc = vector3(1600.7275390625, 2429.994140625, 45.46654510498), Heading = 154.19}, ExitFence = true},
    -- [30] = {StartLoc = {Loc = vector3(1539.9753417969, 2535.681640625, 43.411609649658), Heading = 94.72}, ExitLoc = {Loc = vector3(1537.3840332031, 2535.4677734375, 45.400444030762), Heading = 94.72}, ExitFence = true},
    -- [31] = {StartLoc = {Loc = vector3(1555.5706787109, 2638.220703125, 43.40873336792), Heading = 80.13}, ExitLoc = {Loc = vector3(1553.6495361328, 2638.5546875, 45.380565643311), Heading = 80.13}, ExitFence = true},
    -- [32] = {StartLoc = {Loc = vector3(1612.7268066406, 2719.677734375, 43.389865875244), Heading = 48.96}, ExitLoc = {Loc = vector3(1610.7020263672, 2721.3942871094, 45.390205383301), Heading = 49.79}, ExitFence = true},
    -- [33] = {StartLoc = {Loc = vector3(1722.103515625, 2759.9365234375, 43.389808654785), Heading = 5.83}, ExitLoc = {Loc = vector3(1721.8388671875, 2762.5234375, 45.469844818115), Heading = 5.83}, ExitFence = true},
    -- [34] = {StartLoc = {Loc = vector3(1811.4265136719, 2730.2138671875, 43.389869689941), Heading = 325.4}, ExitLoc = {Loc = vector3(1812.5876464844, 2731.9035644531, 45.41854095459), Heading = 324.84}, ExitFence = true},
    -- [35] = {StartLoc = {Loc = vector3(1832.2895507812, 2654.2846679688, 43.200504302979), Heading = 257.19}, ExitLoc = {Loc = vector3(11834.8247070312, 2653.7084960938, 45.467952728271), Heading = 257.19}, ExitFence = true}
}


Config.RoomTools = { -- Todas las herramientas para celdas y ubicaciones de salida
    [1] = {
        Name = "Cuchara Rota", -- Nombre de la herramienta
        Item = 'hd_jspoon', -- Nombre del objeto en la base de datos de la herramienta
        Time = 10, -- Cuánto tiempo lleva usarla
        Percent = 2 -- Probabilidad en porcentaje de que funcione (por ejemplo, 2 = 20%)
    },
    [2] = {
        Name = "Cuchara Rota con Paño Húmedo",
        Item = 'hd_bcloth',
        Time = 7,
        Percent = 5
    },
    [3] = {
        Name = "Metal Afilado",
        Item = 'hd_smetal',
        Time = 5,
        Percent = 8
    },
    [4] = {
        Name = "Ácido",
        Item = 'hd_acid',
        Time = 20,
        Percent = 8
    },
    [5] = {
        Name = "Martillo Miniatura",
        Item = 'hd_minih',
        Time = 25,
        Percent = 9
    }
}

Config.FenceTool = { -- Herramientas para cercas que no son ubicaciones de salida
    [1] = {
        Name = "Lima", -- Nombre de la herramienta
        Item = 'hd_file', -- Nombre en la base de datos de la herramienta
        Time = 10, -- Cuánto tiempo lleva
        Percent = 4 -- Probabilidad en porcentaje de que funcione (por ejemplo, 4 = 40%)
    },
    [2] = {
        Name = "Metal Afilado",
        Item = 'hd_smetal',
        Time = 4,
        Percent = 7
    },
    [3] = {
        Name = "Ácido",
        Item = 'hd_acid',
        Time = 20,
        Percent = 9
    },
    [4] = {
        Name = "Martillo Miniatura",
        Item = 'hd_minih',
        Time = 15,
        Percent = 7
    },
    [5] = {
        Name = "Calentador de Inmersión",
        Item = 'hd_iheat',
        Time = 20,
        Percent = 9
    }
}



Config.WatchMarkNum = 1 --Número del marcador de la torre de vigilancia
Config.WatchMarkColor = {r = 255, g = 0, b = 0} --Color del marcador de la torre de vigilancia

Config.WatchBlip = {Spawn = true, Sprite = 181, Color = 1, Size = 0.7} --Configuración del indicador de la torre de vigilancia
Config.WatchDist = 20.0 --Tamaño del círculo o distancia necesaria
Config.MaxWatchDist = 150 --Distancia necesaria para escapar por completo
Config.SeeWatchDist = 75 --Distancia necesaria para ver el círculo 3D
Config.WatchTowers = { --Todas las ubicaciones de las torres de vigilancia
    [1] = vector3(1823.9467773438, 2621.1137695312, 45.8014793396),
    [2] = vector3(1848.8317871094, 2699.4509277344, 45.8014793396),
    [3] = vector3(1773.2802734375, 2762.8894042969, 45.8014793396),
    [4] = vector3(1649.5051269531, 2758.0935058594, 45.8014793396),
    [5] = vector3(1569.8160400391, 2680.447265625, 45.8014793396),
    [6] = vector3(1534.6882324219, 2585.3349609375, 45.550983428955),
    [7] = vector3(1540.5181884766, 2469.6254882812, 45.550983428955),
    [8] = vector3(1658.923828125, 2394.5964355469, 45.550983428955),
    [9] = vector3(1761.4342041016, 2410.2609863281, 45.550983428955),
    [10] = vector3(1824.2727050781, 2475.5314941406, 45.550983428955),
    [11] = vector3(1822.5385742188, 2574.7231445312, 45.67200088501)
}

--Configuraciones de duchas
Config.Showers = true --Si quieres que haya duchas en la prisión
Config.ShowerLoc = {Loc = vector3(3909.3359, 41.9588, 23.8882), Heading = 261.21} --Cambiar la ubicación de las duchas
Config.ShowerBlip = {Spawn = true, Sprite = 272, Color = 0, Size = 0.9} -- Configuración del indicador de las duchas

Config.ShowMarkNum = 21 --Número del marcador 3D de las duchas
Config.ShowMarkColor = {r = 50, g = 109, b = 168} --Color del marcador 3D de las duchas
Config.ShowMarkSize = {x = 0.5, y = 0.5, z = 0.5} --Tamaño del marcador 3D de las duchas

Config.GetReadyTime = 5 --Tiempo necesario para cambiarse
Config.ShowerFullDist = 7 --Distancia necesaria para ver el marcador 3D
Config.ShowerMarkerDist = 10 --Distancia necesaria para ver el marcador inicial
Config.ShowerDist = 1 --Distancia necesaria para usar la ducha
Config.MaxDistShower = 20 --Distancia máxima antes de cancelar la ducha

Config.ShowerLocs = { --Todas las ubicaciones de las duchas
    [1] = vector3(3907.3303, 37.1681, 23.8882),
    [2] = vector3(3907.2927, 38.3814, 23.8882),

    [3] = vector3(3907.3420, 39.3693, 23.8882),
    [4] = vector3(3907.3760, 40.5676, 23.8882),

    [5] = vector3(3906.3972, 37.5754, 23.8882),
    [6] = vector3(3906.4219, 38.3923, 23.8882),

    [7] = vector3(3906.4536, 39.7863, 23.8882),
    [8] = vector3(3906.4224, 40.4748, 23.8882),

}

Config.ShowerFit = { --Ropa para ducharse (el personaje debe estar desnudo o usar pantalones)
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

--Ejercicio
Config.WorkingOut = false --Si se puede hacer ejercicio en la prisión

Config.WorkOutBlip = {Spawn = true, Sprite = 354, Color = 1, Size = 0.7} --Configuración de los indicadores de las áreas de ejercicio

Config.WoutMarkNum = 21 --Números de los marcadores 3D de ejercicio
Config.WoutMarkColor = {r = 255, g = 0, b = 0} --Colores de los marcadores 3D de ejercicio
Config.WoutMarkSize = {x = 0.5, y = 0.5, z = 0.5} --Tamaño de los marcadores 3D de ejercicio

Config.WorkoutLocs = { --Todas las áreas de ejercicio
    [1] = {
        StartLoc = {Loc = vector3(3955.4849, 45.7681, 22.3427), Heading = 46.3432}, --Ubicación inicial para cambiarse en esta área
        Locs = { --Todas las ubicaciones de ejercicio del área (Label = Name of task, Loc = location of marker, Heading = direction you are facing, Anim.Dict = Animation Dictionary / Scenario, Anim.Aim = Animation thats played within that Dictionary(leave nil if scenario), Time = How long it plays anim (in secs))
            [1] = {Label = "Saco de boxeo", Loc = vector3(3954.03, 50.35, 22.74), Heading = 102.13, Anim = {Dict = 'anim@mp_player_intcelebrationmale@shadow_boxing', Aim = 'shadow_boxing'}, Time = 10},
            [2] = {Label = "Saco de boxeo", Loc = vector3(3948.72, 50.08, 22.44), Heading = 71.74, Anim = {Dict = 'anim@mp_player_intcelebrationmale@shadow_boxing', Aim = 'shadow_boxing'}, Time = 10},
            [3] = {Label = "Dominadas", Loc = vector3(3955.64, 56.02, 22.34), Heading = 355.77, Anim = {Dict = 'PROP_HUMAN_MUSCLE_CHIN_UPS', Aim = nil}, Time = 10},
            [4] = {Label = "Dominadas", Loc = vector3(1773.1776123047, 2596.8159179688, 45.797824859619), Heading = 268.73, Anim = {Dict = 'PROP_HUMAN_MUSCLE_CHIN_UPS', Aim = nil}, Time = 10},
            [5] = {Label = "Flexiones", Loc = vector3(1769.6988525391, 2594.8115234375, 45.797824859619), Heading = 92.1, Anim = {Dict = 'amb@world_human_push_ups@male@idle_a', Aim = 'idle_d'}, Time = 10},
            [6] = {Label = "Flexiones", Loc = vector3(1766.0317382812, 2594.7741699219, 45.797824859619), Heading = 92.1, Anim = {Dict = 'amb@world_human_push_ups@male@idle_a', Aim = 'idle_d'}, Time = 10},
            [7] = {Label = "Yoga", Loc = vector3(1767.1796875, 2597.2023925781, 45.797824859619), Heading = 357.68, Anim = {Dict = 'WORLD_HUMAN_YOGA', Aim = nil}, Time = 10},
            [8] = {Label = "Yoga", Loc = vector3(1770.4311523438, 2597.5068359375, 45.797824859619), Heading = 269.02, Anim = {Dict = 'WORLD_HUMAN_YOGA', Aim = nil}, Time = 10}
        }
    },
    -- [2] = {
    --     StartLoc = {Loc = vector3(1645.4556884766, 2536.8881835938, 45.56489944458), Heading = 224.19},
    --     Locs = {
    --         [1] = {Label = "Dominadas", Loc = vector3(1648.861328125, 2529.6850585938, 45.56489944458), Heading = 232.36, Anim = {Dict = 'PROP_HUMAN_MUSCLE_CHIN_UPS', Aim = nil}, Time = 10},
    --         [2] = {Label = "Dominadas", Loc = vector3(1643.1571044922, 2527.9553222656, 45.56489944458), Heading = 230.56, Anim = {Dict = 'PROP_HUMAN_MUSCLE_CHIN_UPS', Aim = nil}, Time = 10},
    --         [3] = {Label = "Flexiones", Loc = vector3(1645.3740234375, 2525.0317382812, 45.56489944458), Heading = 229.27, Anim = {Dict = 'amb@world_human_push_ups@male@idle_a', Aim = 'idle_d'}, Time = 10},
    --         [4] = {Label = "Flexiones", Loc = vector3(1647.0649414062, 2527.0151367188, 45.56489944458), Heading = 229.75, Anim = {Dict = 'amb@world_human_push_ups@male@idle_a', Aim = 'idle_d'}, Time = 10},
    --         [5] = {Label = "Yoga", Loc = vector3(1639.0922851562, 2531.6369628906, 45.56489944458), Heading = 50.31, Anim = {Dict = 'WORLD_HUMAN_YOGA', Aim = nil}, Time = 10},
    --         [6] = {Label = "Yoga", Loc = vector3(1636.4968261719, 2528.7780761719, 45.56489944458), Heading = 50.95, Anim = {Dict = 'WORLD_HUMAN_YOGA', Aim = nil}, Time = 10},
    --         [7] = {Label = "Yoga", Loc = vector3(1641.2993164062, 2534.5576171875, 45.564907073975), Heading = 50.68, Anim = {Dict = 'WORLD_HUMAN_YOGA', Aim = nil}, Time = 10},
    --         [8] = {Label = "Abdominales", Loc = vector3(1635.4010009766, 2524.4096679688, 45.564907073975), Heading = 140.72, Anim = {Dict = 'amb@world_human_sit_ups@male@idle_a', Aim = 'idle_a'}, Time = 10},
    --         [9] = {Label = "Abdominales", Loc = vector3(1637.3043212891, 2522.7822265625, 45.564907073975), Heading = 140.01, Anim = {Dict = 'amb@world_human_sit_ups@male@idle_a', Aim = 'idle_a'}, Time = 10}
    --     }
    -- }
}

Config.SeeWorkDist = 7 --Distancia necesaria para ver el marcador 3D
Config.WorkReadyTime = 5 --Tiempo necesario para prepararse para hacer ejercicio (en segundos)
Config.MaxDistWorkout = 10 --Distancia máxima antes de cancelar automáticamente el ejercicio
Config.WorkText = 1 --Distancia necesaria para ver el texto de trabajo
Config.WorkoutFit = { --Ropa de ejercicio para mujer y hombre
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


--Todos los mensajes
Config.RanMessages = {
    [1] = "¡Huelo mal! ¡Ve a tomar una ducha!",
    [2] = "¡Te ves débil! ¡Ve a hacer ejercicio!",
    [3] = "¡Estás siendo perezoso! ¡Ve a hacer tu trabajo!"
}

Config.Sayings = { --Todos los mensajes del recurso
   [1] = "Prisión Federal de Alcatraz",
    [2] = "Realizando Tarea",
    [3] = " ~y~Prisión Federal de Alcatraz~w~ | Tiempo Restante:~r~ ",
    [4] = "(s) ~w~| Trabajo =~o~ ",
    [5] = "Te Están Enviando a la Cárcel",
    [6] = "Ninguno",
    [7] = "Juez",
    [8] = " ha sido setenciado(a) a ",
    [9] = "Gestor de Trabajo en la Cárcel",
    [10] = "Anciano",
    [11] = "Recuperación de Objetos en la Cárcel",
	[12] = "[~p~E~w~] Recuperar Objetos",
    [13] = "Recogiendo Pertinencias",
    [14] = "[~p~E~w~] Gestor de Trabajo",
    [15] = "Trabajos Disponibles",
    [16] = "Sin Trabajo",
    [17] = "Tareas: ",
    [18] = "Deducción de Tiempo: ",
    [19] = "Comenzar Trabajo",
    [20] = "¡Elegiste un trabajo! ¡Ve a hacer las tareas!",
    [21] = "(mins) en la Prisión Federal de Alcatraz | Razón: ",
    [22] = "[~y~E~w~] ",
    [23] = "Realizando Tarea",
    [24] = "¡Completaste una tarea! ¡Ve a la siguiente tarea!",
    [25] = "¡Completaste todas las tareas! ¡Se redujo tu tiempo y las tareas se reiniciaron!",
    [26] = "Tarea: ",
    [27] = "[~y~E~w~] Anciano",
    [28] = "[~o~E~w~] Comenzar a Cavar",
    [29] = "[~b~E~w~] Levantar Cama",
    [30] = "[~g~E~w~] Obtener Comida",
    [31] = "Inventario",
    [32] = "Cafetería",
    [33] = "Sin Objetos",
    [34] = "Debajo de la Cama",
    [35] = "Levantando la Cama",
    [36] = "Bajando la Cama",
    [37] = "¿Cuántos quieres sacar?",
    [38] = "Cantidad/Mensaje Inválido",
    [39] = "La cantidad es demasiado alta",
    [40] = "Eliminar Objetos",
    [41] = "Agregar Objetos",
    [42] = "¿Cuántos te gustaría agregar?",
    [43] = "Tomando bandeja de comida",
    [44] = "[~y~E~w~] Comer Comida [~g~G~w~] Tirar",
    [45] = "¿Sobre qué te gustaría hablar?",
    [46] = "Escapando de aquí",
    [47] = "Creando Objetos",
    [48] = "¿Qué estabas buscando hacer?",
    [49] = "¿Y sobre escapar?",
    [50] = "Lo que necesito",
    [51] = "Créalo",
    [52] = "Necesario",
    [53] = " ~r~Celda de Castigo ~w~| Tiempo Restante: ~y~",
    [54] = "~w~(~r~s~w~)",
    [55] = "Información de Encarcelamiento",
    [56] = "ID: ",
    [57] = "Tiempo: ",
    [58] = "Tiempo: Ninguno",
    [59] = "Razón",
    [60] = "Confirmar",
    [61] = "Cambiar ID para Encarcelamiento",
    [62] = "¡El tiempo de cárcel es demasiado largo, superior al tiempo máximo en la cárcel!",
    [63] = "Cambiar Cantidad de Tiempo",
    [64] = "Razón de Encarcelamiento",
    [65] = "Editar Razón",
    [66] = "Confirmar Razón",
    [67] = "Ver Razón",
    [68] = "Razón de Cárcel",
    [69] = "Ninguna",
    [70] = "El Doctor te está examinando",
    [71] = "¿Sobre qué te gustaría saber?",
    [72] = "Escapando de la Celda",
    [73] = "Rompiendo la Valla 1",
    [74] = "Rompiendo la Valla 2",
    [75] = "Descripción",
    [76] = "Herramientas que se pueden usar",
    [77] = "¡Necesitas una herramienta para cavar a través de la pared! ¡Una vez que hagas un agujero, puedes trepar!",
    [78] = "¡Necesitas una herramienta para cortar la valla! ¡Una vez que cortes, puedes trepar!",
    [79] = "¡Necesitas una herramienta para cavar a través del suelo y la pared! ¡Una vez que hagas un agujero, puedes salir arrastrándote!",
    [80] = "Tiempo: ",
    [81] = "~w~(~y~s~w~)",
    [82] = "Porcentaje de Éxito: ",
    [83] = "Objetos Faltantes para Crear",
    [84] = "Acción No Posible",
    [85] = "Creando",
    [86] = "Robaste un(a) ",
    [87] = "¿Con qué te gustaría cavar?",
    [88] = "¡No tienes este objeto!",
    [89] = "[~o~E~w~] Escapar",
    [90] = "Tu excavación fue exitosa",
    [91] = "Tu herramienta se rompió",
    [92] = "¡Estás ~b~Escapando~w~! | Tiempo Hasta que los Guardias se Den Cuenta:~o~ ",
    [93] = "[~g~E~w~] Cortar Valla",
    [94] = "¿Con qué te gustaría cortar?",
    [95] = "¡No tienes este objeto!",
    [96] = "Cavando",
    [97] = "Cortando",
    [98] = "Cavar / Cortar",
    [99] = "Torre de Vigilancia",
    [100] = "¡Tienes que cavar exitosamente ",
    [101] = " veces para atravesar la pared!",
    [102] = "¡Terminaste de cavar! ¡Arrástrate por el agujero para empezar tu escape!",
    [103] = "¡Esa ID no está en la cárcel!",
    [104] = "(s) fue añadido a tu condena!",
    [105] = "Tu razón es inválida",
    [106] = "Tu ID es inválida",
    [107] = "Tu tiempo es inválido",
    [108] = "No Lograste Escapar a Tiempo",
    [109] = "Te Alejaste Demasiado de la Cárcel",
    [110] = "Mataste a Alguien en la Cárcel",
    [111] = "¡Te alejaste demasiado y el Menú se Cerró!",
    [112] = "Duchas",
    [113] = "[~b~E~w~] Prepararse para la Ducha",
    [114] = "Cambiando de Ropa",
    [115] = "Ve a una de las duchas",
    [116] = "[~b~G~w~] Ducharse",
    [117] = "¡Ducha Cancelada! ¡Te alejaste demasiado!",
    [118] = "Duchándose",
    [119] = "Haciendo Ejercicio",
    [120] = "[~r~E~w~] Comenzar a Hacer Ejercicio",
    [121] = "¡Estás haciendo ejercicio! ¡Usa una de las máquinas o usa el suelo!",
    [122] = "[~r~G~w~] ",
    [123] = "Haciendo Ejercicio",
    [124] = "¡Ejercicio Cancelado! ¡Te alejaste demasiado!",
    [125] = "Ejercicio Terminado",
    [126] = "[~r~E~w~] Terminar de Hacer Ejercicio",
    [127] = "ID Inválida",
    [128] = "Encarcelar a Alguien",
    [129] = "Desencarcelar a Alguien",
    [130] = "Agregar Tiempo a Alguien",
    [131] = "Quitar Tiempo a Alguien",
    [132] = "Enviar a Alguien a la Celda de Castigo",
    [133] = "Opciones de Encarcelamiento",
    [134] = "Ingresa la ID del Jugador",
    [135] = "No Hay Jugadores Cerca",
    [136] = "La Celda de Castigo no está Permitida",
    [137] = " ~y~Prisión Federal de Alcatraz~w~ | Tiempo:~r~ ",
    [138] = " | Trabajo =~o~ ",
    [139] = "Comiendo",
    [140] = " fue añadido a tu condena!",
    [141] = "¡El tiempo es demasiado largo para quitarlo!",
    [142] = " fue removido de tu condena!",
    [143] = "(s) fue removido de tu condena!",
    [144] = "Quitar a Alguien de la Celda de Castigo",
    [145] = "Bloqueo: ",
    [146] = "Activado",
    [147] = "Desactivado",
    [148] = "¡No se puede Activar/Desactivar el Bloqueo, actualmente está en cuenta regresiva!",
    [149] = "(s) ¡Hasta el Bloqueo! ¡Ve a tu celda!",
    [150] = "Saliste de la Celda Durante el Bloqueo",
    [151] = "Ya no estás en Celda de Castigo",
    [152] = "¡Ahora estás en Celda de Castigo!",
    [153] = "Comenzó el Bloqueo, ¡Esto estará en efecto en ",
    [154] = "(s)!",
    [155] = "Todos los Jugadores en Esta Celda",
    [156] = " | ID: ",
    [157] = " Cama de ",
    [158] = "[~o~E~w~] Levantar Cama",
    [159] = "Acción no Permitida",
    [160] = "Prisión",
    [161] = "Arrastrándose a Través del Agujero",
    [162] = "¡No se puede usar!",
    [163] = "¡Bebiste un poco de licor!",
    [164] = "¡Bebiste un poco de ponche!",
    [165] = "Notificar a Todos los Prisioneros",
    [166] = "¿Qué te gustaría decirles?",
    [167] = "¡No se puede confirmar! ¡Razón inválida!",
    [168] = "[Intercomunicador de la Prisión] : ",

    [169] = "Bienvenido a la Prisión Federal de Alcatraz",
    [170] = "~y~Si quieres reducir el tiempo tendras que trabajar",
    [171] = "~g~Aqui tienes alimentacion pero no es gratis",
    [172] = "~r~Si no te portas bien seras aislado del resto",
    [173] = "~o~Puedes hacer Ejercicio para Fortalecerte",
    [174] = "~b~No olvides tomar Duchas para Mantenerte Limpio",
    [175] = "~r~Si llegas a sufrir una lesion puedes Pedir Ayuda a un Doctor",
    [176] = "~y~No olvides recoger tus Objetos al Salir",
    [177] = "~g~Explora y conoce hay muchas cosas ocultas",
    [178] = " ¡No Está en su Celda! ¡Escapó de la Cárcel!"

}
Config.JobIntroCam1 = vector3(3916.00928, 26.9864845, 25.4628868)
Config.JobIntroCam2 = vector3(3915.631, 22.7850742, 23.87154)
Config.JobIntroCamHeading = 173.9453
