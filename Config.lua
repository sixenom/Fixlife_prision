Config = {}

-- ============================================================================
-- 1. CONFIGURACION BASE, PERMISOS Y DISTANCIAS
-- ============================================================================
-- No modificar
Config.CurrentV = "1.0 HD" -- No modificar

-- Configuraciones Importantes
Config.UsingHDBlips = true -- Esto es si estás usando mi script de manejo gratuito de indicadores (blips). Si es así, solo funcionará para el indicador de prisión.
Config.SyncInterval = 2 -- Con qué frecuencia el servidor actualiza la base de datos para los tiempos restantes de los jugadores
Config.MaxPerCell = 2 -- Cuántos están permitidos por celda. Se recomienda dejarlo alto.
Config.MaxJail = 600 -- La cantidad máxima por la que alguien puede ser inicialmente encarcelado.

Config.ServerName = 'Fixlife RP' -- Nombre del servidor que se mostrará en el texto 2D. Si quieres que esté en blanco, déjalo en blanco.

Config.PoliceNotifyTime = 5 -- Cuánto tiempo tarda la policía en enterarse de que alguien escapó (en minutos).
Config.PoliceRoles =
    { -- Todos los roles de la policía para que tengan acceso a buscar y usar el menú.
        'police'
    }
Config.PoliceRanks =
    { -- Todos los rangos que pueden usar ciertas cosas en el menú.
        Jailing = { -- mandar a prision
            {Job = 'police', Grade = 1}
        },
        UnJail = { -- sacar de prision
            {Job = 'police', Grade = 1}
        },
        AddTime = { -- añadir tiempo
            {Job = 'police', Grade = 1}
        },
        RemoveTime = { -- remover tiempos
            {Job = 'police', Grade = 5}
        },
        Send2Solitary = { -- mandar a solitario
            {Job = 'police', Grade = 2}
        },
        RemoveFromSolitary = { ---quitar de solitario
            {Job = 'police', Grade = 2}
        },
        Lockdown = { -- bloquear celdas
            {Job = 'police', Grade = 2}
        },
        Message = { -- mensaje a la prision
            {Job = 'police', Grade = 4}
        }
    }
Config.DefaultSetJob = {Name = 'unemployed', Grade = 0} -- Este es el trabajo predeterminado que se establecerá si no está guardado de alguna manera en la base de datos
Config.SimpleTime = false -- Esto es si deseas que el tiempo sea en segundos solamente, se recomienda dejarlo en false

-- Configuraciones Generales
Config.SeeDist = 5 -- Qué tan cerca debes estar para ver los marcadores 3D

Config.JailBlip = {Spawn = false, Sprite = 238, Color = 1, Size = 0.7} -- Todas las configuraciones relacionadas con el indicador (blip) de la prisión
Config.JailLoc = vector3(3908.3909, 25.6009, 48.8995) -- Ubicación de la prisión (generalmente el centro para que no dé lugar a errores al verificar la ubicación)
Config.TpBack = true -- Si los jugadores son teleportados de regreso cuando salen de la prisión sin usar el script de escape (se recomienda mantenerlo en true)
Config.MaxTpDist = 250 -- A qué distancia se te teleportará de regreso
Config.MaxSolTpDist = 5 -- A qué distancia te teleportará de regreso desde la celda de castigo
Config.MaxMenuDist = 2 -- Distancia máxima antes de cerrar el menú

Config.RanMessage = true -- Si da notificaciones aleatorias para los prisioneros
Config.RanMessageTime = 5 -- Cada cuánto tiempo envía un mensaje (en minutos)
-- Configuraciones de Bloqueo
Config.StartLockCount = 60 -- Tiempo inicial para el bloqueo (en segundos)
Config.WarnLockNums = {45, 30, 15, 10, 5, 4, 3, 2, 1} -- Todas las notificaciones de advertencia para el tiempo de bloqueo, asegúrate de que estén dentro del número anterior

Config.LockDownDist = 4 -- Cuánto puedes alejarte de la celda antes de ser teleportado de regreso o enviado a la celda de castigo

-- Configuraciones de Búsqueda Policial
Config.PoliceCanSearchInv = true -- Si la policía puede registrar los inventarios

Config.SeePoliceDist = 5 -- Qué tan cerca debes estar para ver los marcadores 3D

-- Configuraciones de Objetos Utilizables
Config.ShankWeapon = 'weapon_knife' -- Nombre del arma para el shank (no cambiar)
Config.ShankItem = true -- Si el shank/arma se usa en el inventario de la barra de acceso rápido
Config.ShankAllowed = true -- Si se puede usar el shank

Config.BoozeAllowed = true -- Si se puede usar el objeto booze
Config.BoozeEffect = true -- Si el consumo de booze tiene un efecto
Config.BoozeGive = 80000 -- Cuánta sed se sacia al beber booze (de 1,000,000)
Config.BoozeEffectTime = 30 -- Cuánto tiempo dura el efecto

Config.PunchAllowed = true -- Si se puede usar el objeto punch
Config.PunchGive = 100000 -- Cuánta sed se sacia al beber punch (de 1,000,000)

-- Guía de Entrada
Config.HaveGuide = true -- Si hay una guía de la prisión cuando son enviados por primera vez
Config.TimePer = 5 -- Cuánto tiempo por cámara para la guía (en segundos)

-- ============================================================================
-- 2. ENTRADA A PRISION Y CAMARAS DE INTRODUCCION
-- ============================================================================
Config.PrisonIntroDuration = 20
Config.PrisonIntroBlend = 1200
Config.PrisonIntroBank = 6.0
Config.PrisonIntroBob = 0.12
Config.PrisonIntroPath = {
    {
        Mode = 'Orbit',
        From = vector3(4162.24072, 28.1750088, 53.0),
        To = vector3(4065.01123, -72.59, 53.0),
        Center = vector3(4065.01123, 28.1750088, 17.7991829),
        Direction = -1
    }, {
        Mode = 'Linear',
        From = vector3(4065.01123, -72.59, 53.0),
        To = vector3(3810.63916, -72.59, 53.0),
        FixedRotation = {x = -18.0, y = 0.0, z = 0.0}
    }, {
        Mode = 'Orbit',
        From = vector3(3810.63916, -72.59, 53.0),
        To = vector3(3720.70044, 32.40902, 53.0),
        Center = vector3(3810.63916, 32.40902, 14.8724775),
        Direction = -1
    }
}

Config.JobCam = vector3(3915.46, 24.37, 23.89) -- Posición de la vista de la cámara

Config.SolCam = vector3(3889.2332, 26.5927, 27.4285) -- Posición de la vista de la cámara (Solo se muestra si el aislamiento está activado)

Config.ShowerCam = vector3(3910.1936, 39.0764, 24.9793) -- Posición de la vista de la cámara (Solo se muestra si las duchas están activadas)

Config.FoodCam = vector3(3929.5596, 29.0406, 24.9793) -- Posición de la vista de la cámara

Config.HospitalCam = vector3(4032.4121, 0.2040, 20.0884) -- Posición de la vista de la cámara (Solo se muestra si el hospital está activado)
Config.HospitalCamRot = {x = -25.0, y = 0.0, z = 180.0} -- Rotación de la vista de la cámara (Solo se muestra si el hospital está activado)

Config.ItemCam = vector3(3865.8289, -23.6205, 7.8507) -- Posición de la vista de la cámara (Solo se muestra si hay objetos para guardar)

-- Configuraciones de la escena de entrada a prisión (No modificar si no sabes lo que haces)
Config.GuardPed = 'csb_cop' -- Personaje que te lleva al interior
Config.GuardSpawn = {
    Loc = vector3(465.0160, -998.6136, 22.8469),
    Heading = 300.0
} -- Ubicación donde aparece el guardia check
Config.HandCuffLoc = {
    Loc = vector3(465.2975, -999.2302, 22.8469),
    Heading = 300.0
}
Config.ClothesLoc = {
    Loc = vector3(467.8503, -1001.4005, 22.8469),
    Heading = 90.0
} -- Ubicación a la que te lleva el guardia
Config.ClothesProp = 'prop_cs_t_shirt_pile' -- Objeto que aparece en las manos y sobre la mesa
Config.ClothPropLoc = {
    Loc = vector3(466.706726, -1000.86926, 23.75275),
    Heading = 180.0
} -- Ubicación donde aparece el objeto

Config.PreComputerLoc = {
    Loc = vector3(468.1209, -999.9722, 22.8469),
    Heading = 90.0
}

Config.ComputerLoc = {
    Loc = vector3(465.9052, -1002.4626, 22.8469),
    Heading = 270.0
} -- Ubicación donde el guardia mira su computadora
Config.PointLoc = {
    Loc = vector3(465.9089, -1001.2302, 22.8418),
    Heading = 270.0
} -- Ubicación donde llega y señala el guardia
Config.GrabLoc = {Loc = vector3(469.1391, -1000.9457, 22.8469), Heading = 270.0} -- Ubicación a la que va el guardia para recoger al jugador
Config.GrabTurnHead = 45.0 -- Dirección hacia la salida
Config.PedGrabHeading = 270.0 -- Dirección hacia la que miras al ser sujetado
Config.StopnLook = {
    Loc = vector3(465.6371, -999.6112, 22.8469),
    Heading = 270.0
} -- Punto de parada y avance del guardia para evitar problemas
Config.StopnLook2 = 85.28 -- Dirección del segundo punto de parada
Config.StopnTurn = {Loc = vector3(464.8575, -998.8878, 22.8469), Heading = 90.0} -- Otro punto de parada y avance
Config.Undressed = { -- Ropa del jugador sin prendas
    male = {
        ['tshirt_1'] = 15,
        ['tshirt_2'] = 0,
        ['torso_1'] = 346,
        ['torso_2'] = 0,
        ['decals_1'] = 0,
        ['decals_2'] = 0,
        ['arms'] = 5,
        ['pants_1'] = 346,
        ['pants_2'] = 6,
        ['shoes_1'] = 8,
        ['shoes_2'] = 0,
        ['mask_1'] = 0,
        ['mask_2'] = 0,
        ['bproof_1'] = 0,
        ['bproof_2'] = 0,
        ['chain_1'] = 0,
        ['chain_2'] = 0,
        ['helmet_1'] = -1,
        ['helmet_2'] = 0,
        ['glasses_1'] = 0,
        ['glasses_2'] = 0
    },
    female = {
        ['tshirt_1'] = 14,
        ['tshirt_2'] = 0,
        ['torso_1'] = 358,
        ['torso_2'] = 0,
        ['decals_1'] = 0,
        ['decals_2'] = 0,
        ['arms'] = 4,
        ['pants_1'] = 179,
        ['pants_2'] = 6,
        ['shoes_1'] = 181,
        ['shoes_2'] = 0,
        ['mask_1'] = 0,
        ['mask_2'] = 0,
        ['bproof_1'] = 0,
        ['bproof_2'] = 0,
        ['chain_1'] = 0,
        ['chain_2'] = 0,
        ['helmet_1'] = -1,
        ['helmet_2'] = 0,
        ['glasses_1'] = 0,
        ['glasses_2'] = 0
    }
}
Config.EnterLoc = vector3(470.2050, -1000.9194, 22.8469) -- Ubicación del letrero
Config.EnterHeadings = {Front = 90.0, Side = 0.0} -- Encabezados del letrero, ambos
Config.WalkLoc = vector3(465.0607, -998.9862, 22.8469) -- Caminata final hacia el destino en el pasillo

Config.Cam = vector3(464.937317, -998.060303, 25.576260)
Config.CamRot = {x = -27.302866, y = 0.061999, z = -141.093887}
Config.TestSceneOnly = false

Config.DontTakeGunUponEntry =
    { -- Todas las armas que no se quitan al entrar en la cárcel

    }
Config.DontTakeItemsUponEntry =
    { -- Estos son todos los objetos que no se quitan al entrar en la cárcel (objetos en lista blanca)
        -- 'manzana'
        ''
    }
Config.DontGiveBackItems =
    { -- Estos son todos los objetos que no se devolverán al agarrar objetos al salir (objetos en lista negra)
        'meth_glass'
    }


-- Configuraciones de Salida
-- ============================================================================
-- 3. SALIDA Y RECUPERACION DE OBJETOS
-- ============================================================================
Config.LeaveLoc = {
    Loc = vector3(1829.1700, 2599.7073, 45.5638),
    Heading = 4.0136
} -- Ubicación de salida con orientación

Config.ItemLoc = {
    Loc = vector3(1829.0867, 2602.6274, 45.8891),
    Heading = 359.1612
} -- Ubicación de dónde recoger objetos
Config.ItemBlip = {Spawn = true, Sprite = 475, Color = 1, Size = 0.7} -- Indicador (blip) para recoger objetos
Config.ShowItemDist = 7 -- Distancia para mostrar el marcador 3D
Config.RetreiveTime = 5 -- Cuánto tiempo se necesita para recoger los objetos de nuevo (en segundos)

-- Configuraciones de Comida
-- ============================================================================
-- 4. COMIDA, INVENTARIO Y ACTIVIDADES DIARIAS
-- ============================================================================
Config.GetFoodLoc = {Loc = vector3(3922.36, 32.64, 23.89), Heading = 87.82} -- Dónde agarrar comida en la prisión
Config.FoodBlip = {Spawn = true, Sprite = 269, Color = 0, Size = 0.9} -- Indicador (blip) en el mapa para agarrar comida en la prisión
Config.GrabFoodTime = 5 -- Cuánto tiempo se necesita para agarrar la comida (en segundos)
Config.EatTime = 7 -- Cuánto tiempo se necesita para comer la comida (en segundos)

Config.FoodAmt = 100000 -- Hambre añadida mediante metadata de Qbox
Config.DrinkAmt = 100000 -- Sed añadida mediante metadata de Qbox

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
-- ============================================================================
-- 5. CREACION, INFORMACION Y ADMINISTRACION DE TRABAJOS
-- ============================================================================
Config.Crafts = { -- Todas las cosas que se pueden crear con el Viejo
    [1] = {
        Name = "Cuchillo improvisado",
        Time = 20,
        MakeItem = 'hd_shank',
        Descripe = "¡Puedes usar esto para defensa personal!",
        Needed = {
            [1] = {Name = "Cuchara rota", Amount = 1, Item = 'hd_jspoon'},
            [2] = {Name = "Monedas", Amount = 2, Item = 'hd_schange'}
        }
    },
    [2] = {
        Name = "Cuchara rota",
        Time = 8,
        MakeItem = 'hd_jspoon',
        Descripe = "¡Puedes usar esto para escapar o para más creaciones!",
        Needed = {[1] = {Name = "Cuchara", Amount = 1, Item = 'hd_spoon'}}
    },
    [3] = {
        Name = "Cuchara rota con trapo húmedo",
        Time = 5,
        MakeItem = 'hd_bcloth',
        Descripe = "¡Puedes usar esto para escapar!",
        Needed = {
            [1] = {Name = "Cuchara rota", Amount = 1, Item = 'hd_jspoon'},
            [2] = {Name = "Tela húmeda", Amount = 1, Item = 'hd_wcloth'}
        }
    },
    [4] = {
        Name = "Tela húmeda",
        Time = 10,
        MakeItem = 'hd_wcloth',
        Descripe = "¡Puedes usar esto para más creaciones!",
        Needed = {
            [1] = {Name = "Limpiador", Amount = 1, Item = 'hd_cleaner'},
            [2] = {Name = "Tela", Amount = 1, Item = 'hd_cloth'}
        }
    },
    [5] = {
        Name = "Lima",
        Time = 20,
        MakeItem = 'hd_file',
        Descripe = "¡Puedes usar esto para escapar o para más creaciones!",
        Needed = {
            [1] = {Name = "Roca", Amount = 2, Item = 'hd_rock'},
            [2] = {Name = "Cucharón roto", Amount = 1, Item = 'hd_bladle'}
        }
    },
    [6] = {
        Name = "Cucharón roto",
        Time = 5,
        MakeItem = 'hd_bladle',
        Descripe = "¡Puedes usar esto para más creaciones!",
        Needed = {[1] = {Name = "Cucharón", Amount = 1, Item = 'hd_ladle'}}
    },
    [7] = {
        Name = "Metal afilado",
        Time = 20,
        MakeItem = 'hd_smetal',
        Descripe = "¡Puedes usar esto para escapar!",
        Needed = {
            [1] = {Name = "Metal", Amount = 1, Item = 'hd_metal'},
            [2] = {Name = "Roca", Amount = 2, Item = 'hd_rock'},
            [3] = {Name = "Lima", Amount = 1, Item = 'hd_file'}
        }
    },
    [8] = {
        Name = "Ácido",
        Time = 30,
        MakeItem = 'hd_acid',
        Descripe = "¡Puedes usar esto para escapar!",
        Needed = {
            [1] = {Name = "Botella", Amount = 1, Item = 'hd_bottle'},
            [2] = {Name = "Grasa", Amount = 3, Item = 'hd_grease'},
            [3] = {Name = "Líquido sucio", Amount = 1, Item = 'hd_dliquid'},
            [4] = {Name = "Limpiador", Amount = 1, Item = 'hd_cleaner'},
            [5] = {Name = "Cuchara", Amount = 1, Item = 'hd_spoon'}
        }
    },
    [9] = {
        Name = "Mini martillo",
        Time = 25,
        MakeItem = 'hd_minih',
        Descripe = "¡Puedes usar esto para escapar!",
        Needed = {
            [1] = {Name = "Metal", Amount = 1, Item = 'hd_metal'},
            [2] = {Name = "Roca", Amount = 1, Item = 'hd_rock'},
            [3] = {Name = "Cucharón", Amount = 1, Item = 'hd_ladle'},
            [4] = {Name = "Tela", Amount = 1, Item = 'hd_cloth'}
        }
    },
    [10] = {
        Name = "Puñetazo de prisión",
        Time = 10,
        MakeItem = 'hd_ppunch',
        Descripe = "¡Puedes usar esto para saciar tu sed!",
        Needed = {
            [1] = {Name = "Líquido sucio", Amount = 1, Item = 'hd_dliquid'},
            [2] = {Name = "Sobre de sabor", Amount = 3, Item = 'hd_fpacket'},
            [3] = {Name = "Botella", Amount = 1, Item = 'hd_bottle'}
        }
    },
    [11] = {
        Name = "Calentador de inmersión",
        Time = 25,
        MakeItem = 'hd_iheat',
        Descripe = "¡Puedes usar esto para destilar alcohol!",
        Needed = {
            [1] = {Name = "Enchufe", Amount = 1, Item = 'hd_plug'},
            [2] = {Name = "Monedas sueltas", Amount = 2, Item = 'hd_schange'}
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
-- ============================================================================
-- 5A. NPCS, BLIPS Y UBICACIONES DE TRABAJO
-- ============================================================================
Config.InfoPed = 'csb_rashcosvki' -- Modelo del peatón del Anciano
Config.InfoPedChangeTime = 3 -- Cuánto tiempo hasta que el anciano cambie de ubicación (en minutos)
Config.InfoPedLoc =
    { -- Todas las ubicaciones en las que podría estar el peatón
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
Config.JobManLoc2 = {
    Loc = vector3(4082.6423, 42.1875, 18.7893),
    Heading = 15.4042
}
Config.JobManBlip = {Spawn = true, Sprite = 267, Color = 0, Size = 0.9} -- Blip del administrador de trabajo
Config.JobManPed = 's_m_m_prisguard_01' -- Peatón del administrador de trabajo
-- ---------------------------------------------------------------------------
-- Lavanderia: vehiculo y puntos de trabajo
-- ---------------------------------------------------------------------------
Config.LaundryVehicleNpcLoc = {
    Loc = vector3(4075.7576, 41.4845, 18.7589),
    Heading = 109.3173
}
Config.LaundryVehicleNpc = 's_m_m_prisguard_01'
Config.LaundryVehicleBlip = {Spawn = true, Sprite = 225, Color = 0, Size = 0.8}
Config.LaundryVehicleModel = 'keitora'
Config.LaundryVehicleSpawns = {
    {Loc = vector3(4072.3806, 46.9707, 18.1827), Heading = 195.6083},
    {Loc = vector3(4070.1611, 46.2174, 18.1829), Heading = 196.8776},
    {Loc = vector3(4068.0347, 45.4887, 18.1828), Heading = 197.1007},
    {Loc = vector3(4065.8792, 44.6971, 18.1822), Heading = 198.6931}
}
Config.LaundryDropLocs = {
    {Loc = vector3(4071.87036, 54.51883, 18.784965), Heading = 12.0},
    {Loc = vector3(4073.456, 54.827877, 18.7849655), Heading = 12.0},
    {Loc = vector3(4075.02368, 55.1541328, 18.7849655), Heading = 12.0},
    {Loc = vector3(4076.43115, 52.6909447, 18.7849655), Heading = 102.0}
}
Config.LaundryDirtyLocs = {
    {Loc = vector3(4071.87036, 54.51883, 18.784965), Heading = 192.0},
    {Loc = vector3(4073.456, 54.827877, 18.7849655), Heading = 192.0},
    {Loc = vector3(4075.02368, 55.1541328, 18.7849655), Heading = 192.0},
    {Loc = vector3(4076.43115, 52.6909447, 18.7849655), Heading = 102.0}
}
Config.LaundryWasherLocs = {
    {Loc = vector3(4062.3667, 55.6071548, 18.5177574), Heading = 12.0},
    {Loc = vector3(4063.69653, 55.8898277, 18.5177574), Heading = 12.0},
    {Loc = vector3(4065.01758, 56.1706619, 18.5177574), Heading = 12.0},
    {Loc = vector3(4066.35449, 56.4548035, 18.5177574), Heading = 12.0}
}
Config.LaundryWasherInteractionOffsets = {
    {0.0, -0.8, 0.8}, {0.0, -0.8, 0.8}, {0.0, -0.8, 0.8}, {0.0, -0.8, 0.8}
}
Config.LaundryDryerLocs = {
    {Loc = vector3(4067.19775, 51.53718, 17.7854881), Heading = 192.0},
    {Loc = vector3(4065.863, 51.2738762, 17.7854881), Heading = 192.0},
    {Loc = vector3(4064.53784, 51.0125542, 17.7854881), Heading = 192.0},
    {Loc = vector3(4063.19678, 50.74868, 17.7854881), Heading = 192.0}
}
Config.LaundryDryerInteractionOffsets = {
    {0.0, -0.8, 0.8}, {0.0, -0.8, 0.8}, {0.0, -0.8, 0.8}, {0.0, -0.8, 0.8}
}
Config.LaundryStorageAction = {
    Loc = vector3(4072.8677, 55.6293, 19.5065),
    Heading = 15.9948,
    Dict = 'mp_am_hold_up',
    Anim = 'purchase_beerbox_shopkeeper',
    Duration = 2500
}

-- Limpieza de basura.
Config.GarbageBagLocs = {
    vector3(4049.3669, 18.1602, 19.4217), vector3(4049.7622, 27.3301, 19.8733),
    vector3(4032.7588, 29.4939, 20.5864), vector3(4039.1104, 23.7680, 21.0787),
    vector3(4026.4204, 30.0082, 22.0508), vector3(4016.3054, 31.1498, 23.2917),
    vector3(4017.4961, 34.5426, 19.7567), vector3(4009.9377, 44.9345, 17.8066),
    vector3(3995.2183, 46.3300, 18.3948), vector3(3970.7842, 19.0812, 21.3606),
    vector3(3960.8936, 17.0454, 19.9066), vector3(3968.1694, 28.0403, 19.9920),
    vector3(3988.7834, 2.3887, 18.2469), vector3(3997.7666, 14.4281, 22.1145),
    vector3(4007.5752, 4.8038, 19.0047), vector3(4020.3044, 20.7892, 20.9281)
}
Config.GarbageBagModels = {
    'prop_rub_binbag_01b', 'prop_rub_binbag_03', 'prop_rub_binbag_03b',
    'prop_rub_binbag_06', 'prop_rub_binbag_08'
}
Config.GarbageDumpsterLocs = {
    {
        Model = 'prop_dumpster_01a',
        Loc = vector3(4019.88086, -2.23630834, 17.75792),
        Heading = 90.0
    }, {
        Model = 'prop_dumpster_02a',
        Loc = vector3(4019.88086, -4.570806, 17.75792),
        Heading = 90.0
    }, {
        Model = 'prop_dumpster_02b',
        Loc = vector3(4019.88086, -6.876818, 17.75792),
        Heading = 90.0
    }, {
        Model = 'prop_dumpster_01a',
        Loc = vector3(4019.88086, -9.086115, 17.75792),
        Heading = 90.0
    }
}
Config.GarbageDumpsterLoc = Config.GarbageDumpsterLocs[3]
Config.GarbageDumpsterModel = Config.GarbageDumpsterLoc.Model
Config.GarbageDumpsterInteractionOffset = {0.0, -1.3, 0.8}
Config.GarbageDumpsterAnim = {
    Dict = '17mov_garbage',
    AnimName = 'ped_dumpster_01a_1',
    PropAnimName = 'prop_dumpster_01a_1',
    Time = 10
}

Config.JMMarkNum = 27 -- Número del marcador 3D del administrador de trabajo
Config.JMMarkColor = {r = 255, g = 0, b = 255} -- Color del marcador 3D del administrador de trabajo
Config.JMMarkSize = {x = 1.0, y = 1.0, z = 0.5} -- Tamaño del marcador 3D del administrador de trabajo

Config.SeeTaskMark = 5 -- Qué tan cerca debes estar para ver el marcador 3D
-- ============================================================================
-- 5B. TRABAJOS Y TAREAS
-- ============================================================================
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
                TaskLoc = {
                    Loc = vector3(3912.31, 40.87, 23.89),
                    Heading = 86.84
                },
                Anim = {
                    Dict = 'anim@amb@business@coc@coc_unpack_cut_left@',
                    AnimName = 'coke_cut_v5_coccutter'
                },
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 235, g = 116, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'prop_sponge_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [2] = {
                TaskName = "Limpiar Mancha",
                TaskLoc = {
                    Loc = vector3(3907.89, 40.91, 23.89),
                    Heading = 87.24
                },
                Anim = {Dict = 'amb@world_human_maid_clean@', AnimName = 'base'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 235, g = 116, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = true,
                    Prop = 'prop_sponge_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'prop_sponge_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [3] = {
                TaskName = "Limpiar Mancha",
                TaskLoc = {
                    Loc = vector3(3907.33, 39.06, 23.89),
                    Heading = 89.68
                },
                Anim = {Dict = 'amb@world_human_maid_clean@', AnimName = 'base'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 235, g = 116, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = true,
                    Prop = 'prop_sponge_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'prop_sponge_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            -- Continúa con las tareas restantes...
            [4] = {
                TaskName = "Limpiar Mancha",
                TaskLoc = {
                    Loc = vector3(3907.33, 36.90, 23.89),
                    Heading = 95.85
                },
                Anim = {Dict = 'amb@world_human_maid_clean@', AnimName = 'base'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 235, g = 116, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = true,
                    Prop = 'prop_sponge_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'prop_sponge_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [5] = {
                TaskName = "Limpiar Mancha",
                TaskLoc = {
                    Loc = vector3(3904.65, 35.00, 23.89),
                    Heading = 179.27
                },
                Anim = {Dict = 'amb@world_human_maid_clean@', AnimName = 'base'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 235, g = 116, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = true,
                    Prop = 'prop_sponge_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'prop_sponge_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [6] = {
                TaskName = "Limpiar Mancha",
                TaskLoc = {
                    Loc = vector3(3904.18, 38.18, 23.89),
                    Heading = 95.42
                },
                Anim = {Dict = 'amb@world_human_maid_clean@', AnimName = 'base'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 235, g = 116, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = true,
                    Prop = 'prop_sponge_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'prop_sponge_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [7] = {
                TaskName = "Limpiar Mancha",
                TaskLoc = {
                    Loc = vector3(3904.66, 42.30, 23.89),
                    Heading = 357.24
                },
                Anim = {Dict = 'amb@world_human_maid_clean@', AnimName = 'base'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 235, g = 116, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = true,
                    Prop = 'prop_sponge_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'prop_sponge_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [8] = {
                TaskName = "Limpiar Mancha",
                TaskLoc = {
                    Loc = vector3(3906.41, 41.06, 23.89),
                    Heading = 283.73
                },
                Anim = {Dict = 'amb@world_human_maid_clean@', AnimName = 'base'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 235, g = 116, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = true,
                    Prop = 'prop_sponge_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'prop_sponge_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [9] = {
                TaskName = "Limpiar Mancha",
                TaskLoc = {
                    Loc = vector3(3906.41, 39.12, 23.89),
                    Heading = 268.37
                },
                Anim = {Dict = 'amb@world_human_maid_clean@', AnimName = 'base'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 235, g = 116, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = true,
                    Prop = 'prop_sponge_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'prop_sponge_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [10] = {
                TaskName = "Limpiar Mancha",
                TaskLoc = {
                    Loc = vector3(3906.39, 36.86, 23.89),
                    Heading = 272.11
                },
                Anim = {Dict = 'amb@world_human_maid_clean@', AnimName = 'base'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 235, g = 116, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = true,
                    Prop = 'prop_sponge_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'prop_sponge_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [11] = {
                TaskName = "Limpiar Mancha",
                TaskLoc = {
                    Loc = vector3(3910.39, 42.27, 23.89),
                    Heading = 359.53
                },
                Anim = {Dict = 'amb@world_human_maid_clean@', AnimName = 'base'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 235, g = 116, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = true,
                    Prop = 'prop_sponge_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'prop_sponge_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [12] = {
                TaskName = "Devolver Limpiador",
                TaskLoc = {
                    Loc = vector3(3912.87, 40.87, 23.89),
                    Heading = 77.67
                },
                Anim = {
                    Dict = 'anim@amb@business@coc@coc_unpack_cut_left@',
                    AnimName = 'coke_cut_v5_coccutter'
                },
                Time = 7,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 235, g = 116, b = 52},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
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
                TaskLoc = {
                    Loc = vector3(4073.8359, 54.1713, 18.7869),
                    Heading = 355.8455
                },
                Anim = {
                    Dict = 'anim@amb@business@coc@coc_unpack_cut_left@',
                    AnimName = 'coke_cut_v5_coccutter'
                },
                Time = 15,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 15,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'bkr_prop_fakeid_binbag_01',
                    Offsets = {
                        First = 0.0,
                        Second = -0.13,
                        Third = 0.0,
                        Four = 0.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [2] = {
                TaskName = "Poner la ropa en la lavadora",
                TaskLoc = {
                    Loc = vector3(4062.6074, 54.7222, 19.5069),
                    Heading = 6.2117
                },
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'prop_ld_tshirt_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [3] = {
                TaskName = "Poner la ropa en la lavadora",
                TaskLoc = {
                    Loc = vector3(4063.9927, 54.9810, 19.5065),
                    Heading = 12.1525
                },
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'prop_ld_tshirt_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [4] = {
                TaskName = "Poner la ropa en la lavadora",
                TaskLoc = {
                    Loc = vector3(4065.2759, 55.3276, 19.4947),
                    Heading = 8.5764
                },
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'prop_ld_tshirt_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [5] = {
                TaskName = "Poner la ropa en la lavadora",
                TaskLoc = {
                    Loc = vector3(4066.6167, 55.5936, 19.5065),
                    Heading = 10.1248
                },
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [6] = {
                TaskName = "Agarra la ropa mojada",
                TaskLoc = {
                    Loc = vector3(4062.6074, 54.7222, 19.5069),
                    Heading = 6.2117
                },
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'prop_ld_tshirt_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [7] = {
                TaskName = "Poner la ropa mojada en la secadora.",
                TaskLoc = {
                    Loc = vector3(4063.2229, 51.7392, 18.7869),
                    Heading = 186.2997
                },
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [8] = {
                TaskName = "Agarra la ropa mojada",
                TaskLoc = {
                    Loc = vector3(4063.9927, 54.9810, 19.5065),
                    Heading = 12.1525
                },
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'prop_ld_tshirt_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [9] = {
                TaskName = "Poner la ropa mojada en la secadora.",
                TaskLoc = {
                    Loc = vector3(4064.4587, 51.9464, 18.7869),
                    Heading = 197.6560
                },
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [10] = {
                TaskName = "Agarra la ropa mojada",
                TaskLoc = {
                    Loc = vector3(4065.2759, 55.3276, 19.4947),
                    Heading = 8.5764
                },
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'prop_ld_tshirt_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [11] = {
                TaskName = "Poner la ropa mojada en la secadora.",
                TaskLoc = {
                    Loc = vector3(4065.8152, 52.1920, 18.7869),
                    Heading = 200.1310
                },
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [12] = {
                TaskName = "Agarra la ropa mojada",
                TaskLoc = {
                    Loc = vector3(4066.6167, 55.5936, 19.5065),
                    Heading = 10.1248
                },
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'prop_ld_tshirt_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [13] = {
                TaskName = "Poner la ropa mojada en la secadora.",
                TaskLoc = {
                    Loc = vector3(4067.0718, 52.4933, 18.7869),
                    Heading = 195.8088
                },
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [14] = {
                TaskName = "Coge ropa seca",
                TaskLoc = {
                    Loc = vector3(4063.2229, 51.7392, 18.7869),
                    Heading = 186.2997
                },
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'prop_ld_tshirt_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [15] = {
                TaskName = "Coge ropa seca",
                TaskLoc = {
                    Loc = vector3(4064.4587, 51.9464, 18.7869),
                    Heading = 197.6560
                },
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'prop_ld_tshirt_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [16] = {
                TaskName = "Coge ropa seca",
                TaskLoc = {
                    Loc = vector3(4065.8152, 52.1920, 18.7869),
                    Heading = 200.1310
                },
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'prop_ld_tshirt_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [17] = {
                TaskName = "Coge ropa seca",
                TaskLoc = {
                    Loc = vector3(4067.0718, 52.4933, 18.7869),
                    Heading = 195.8088
                },
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'prop_ld_tshirt_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [18] = {
                TaskName = "Guarda la ropa",
                TaskLoc = {
                    Loc = vector3(4072.5005, 55.9471, 19.5065),
                    Heading = 22.3862
                },
                Anim = {
                    Dict = 'anim@amb@business@coc@coc_unpack_cut_left@',
                    AnimName = 'coke_cut_v5_coccutter'
                },
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            }
        }
    },
    [3] = {
        Name = "Corredor de lavandería",
        TimeRemove = 10,
        StealChance = 2,
        StealItems = {
            [1] = {Name = "Botella", Item = 'hd_bottle', Chance = 1},
            [2] = {Name = "Tela", Item = 'hd_cloth', Chance = 6}
        },
        Tasks = {
            [1] = {
                TaskName = "Agarra la ropa sucia",
                TaskLoc = {
                    Loc = vector3(4022.66577, -5.482034, 18.7874),
                    Heading = 0.0
                },
                Anim = {Dict = 'anim@heists@box_carry@', AnimName = 'idle'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 2, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 235, b = 82},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'prop_ld_tshirt_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [2] = {
                TaskName = "Dejar la ropa sucia",
                TaskLoc = {
                    Loc = vector3(4071.87036, 54.51883, 18.784965),
                    Heading = 11.8771
                },
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 2, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [3] = {
                TaskName = "Agarra la ropa sucia",
                TaskLoc = {
                    Loc = vector3(3911.752, 35.4029579, 23.8882),
                    Heading = 90.0
                },
                Anim = {Dict = 'anim@heists@box_carry@', AnimName = 'idle'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 2, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 235, b = 82},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'prop_ld_tshirt_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [4] = {
                TaskName = "Dejar la ropa sucia",
                TaskLoc = {
                    Loc = vector3(4073.456, 54.827877, 18.7849655),
                    Heading = 11.8771
                },
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 2, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [5] = {
                TaskName = "Agarra la ropa sucia",
                TaskLoc = {
                    Loc = vector3(3911.2876, 19.5162563, 27.5669651),
                    Heading = 90.0
                },
                Anim = {Dict = 'anim@heists@box_carry@', AnimName = 'idle'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 2, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 235, b = 82},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'prop_ld_tshirt_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [6] = {
                TaskName = "Dejar la ropa sucia",
                TaskLoc = {
                    Loc = vector3(4075.02368, 55.1541328, 18.7849655),
                    Heading = 11.8771
                },
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 2, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [7] = {
                TaskName = "Agarra la ropa sucia",
                TaskLoc = {
                    Loc = vector3(3936.91553, -16.82305, 10.901464),
                    Heading = 90.0
                },
                Anim = {Dict = 'anim@heists@box_carry@', AnimName = 'idle'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 2, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 235, b = 82},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'prop_ld_tshirt_01',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [8] = {
                TaskName = "Dejar la ropa sucia",
                TaskLoc = {
                    Loc = vector3(4076.43115, 52.6909447, 18.784965),
                    Heading = 11.8771
                },
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 2, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 52, g = 155, b = 235},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            }
        }
    },
    -- [4] = {
    --     Name = "Cocinero",
    --     TimeRemove = 25,
    --     StealChance = 4,
    --     StealItems = {
    --         [1] = {Name = "Botella", Item = 'hd_bottle', Chance = 2},
    --         [2] = {Name = "Grasa", Item = 'hd_grease', Chance = 5},
    --         [3] = {Name = "Líquido sucio", Item = 'hd_dliquid', Chance = 5},
    --         [4] = {Name = "Cuchara", Item = 'hd_spoon', Chance = 8},
    --         [5] = {Name = "Cucharón", Item = 'hd_ladle', Chance = 7},
    --         [6] = {Name = "Sobre de sabor", Item = 'hd_fpacket', Chance = 10}
    --     },
    --     Tasks = {
    --         [1] = {
    --             TaskName = "Agarrar sartén",
    --             TaskLoc = {
    --                 Loc = vector3(1778.3149414062, 2593.6015625, 45.797836303711),
    --                 Heading = 202.38
    --             },
    --             Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
    --             Time = 5,
    --             TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
    --             MarkNum = 20,
    --             MarkColor = {r = 229, g = 235, b = 52},
    --             MarkSize = {x = 0.5, y = 0.5, z = 0.3},
    --             AttachItem = {
    --                 Attach = false,
    --                 Prop = 'nil',
    --                 Offsets = {
    --                     First = 0.0,
    --                     Second = 0.0,
    --                     Third = -0.01,
    --                     Four = 90.0,
    --                     Five = 0.0,
    --                     Six = 0.0
    --                 }
    --             },
    --             CarryItem = {
    --                 Attach = true,
    --                 Prop = 'prop_copper_pan',
    --                 Offsets = {
    --                     First = 0.0,
    --                     Second = 0.0,
    --                     Third = -0.01,
    --                     Four = 90.0,
    --                     Five = 0.0,
    --                     Six = 0.0
    --                 }
    --             }
    --         },
    --         [2] = {
    --             TaskName = "Iniciar cocina",
    --             TaskLoc = {
    --                 Loc = vector3(1777.9334716797, 2597.5095214844,
    --                               45.797836303711),
    --                 Heading = 273.88
    --             },
    --             Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
    --             Time = 10,
    --             TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
    --             MarkNum = 20,
    --             MarkColor = {r = 229, g = 235, b = 52},
    --             MarkSize = {x = 0.5, y = 0.5, z = 0.3},
    --             AttachItem = {
    --                 Attach = false,
    --                 Prop = 'nil',
    --                 Offsets = {
    --                     First = 0.0,
    --                     Second = 0.0,
    --                     Third = -0.01,
    --                     Four = 90.0,
    --                     Five = 0.0,
    --                     Six = 0.0
    --                 }
    --             },
    --             CarryItem = {
    --                 Attach = false,
    --                 Prop = 'nil',
    --                 Offsets = {
    --                     First = 0.0,
    --                     Second = 0.0,
    --                     Third = -0.01,
    --                     Four = 90.0,
    --                     Five = 0.0,
    --                     Six = 0.0
    --                 }
    --             }
    --         },
    --         [3] = {
    --             TaskName = "Agarra comida",
    --             TaskLoc = {
    --                 Loc = vector3(1776.4860839844, 2599.3669433594,
    --                               45.797836303711),
    --                 Heading = 355.15
    --             },
    --             Anim = {Dict = 'mp_arresting', AnimName = 'a_uncuff'},
    --             Time = 10,
    --             TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
    --             MarkNum = 20,
    --             MarkColor = {r = 229, g = 235, b = 52},
    --             MarkSize = {x = 0.5, y = 0.5, z = 0.3},
    --             AttachItem = {
    --                 Attach = false,
    --                 Prop = 'nil',
    --                 Offsets = {
    --                     First = 0.0,
    --                     Second = 0.0,
    --                     Third = -0.01,
    --                     Four = 90.0,
    --                     Five = 0.0,
    --                     Six = 0.0
    --                 }
    --             },
    --             CarryItem = {
    --                 Attach = true,
    --                 Prop = 'ng_proc_food_ornge1a',
    --                 Offsets = {
    --                     First = 0.0,
    --                     Second = 0.0,
    --                     Third = -0.01,
    --                     Four = 90.0,
    --                     Five = 0.0,
    --                     Six = 0.0
    --                 }
    --             }
    --         },
    --         [4] = {
    --             TaskName = "Cocinar los alimentos",
    --             TaskLoc = {
    --                 Loc = vector3(1777.9334716797, 2597.5095214844,
    --                               45.797836303711),
    --                 Heading = 273.88
    --             },
    --             Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
    --             Time = 20,
    --             TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
    --             MarkNum = 20,
    --             MarkColor = {r = 229, g = 235, b = 52},
    --             MarkSize = {x = 0.5, y = 0.5, z = 0.3},
    --             AttachItem = {
    --                 Attach = false,
    --                 Prop = 'nil',
    --                 Offsets = {
    --                     First = 0.0,
    --                     Second = 0.0,
    --                     Third = -0.01,
    --                     Four = 90.0,
    --                     Five = 0.0,
    --                     Six = 0.0
    --                 }
    --             },
    --             CarryItem = {
    --                 Attach = false,
    --                 Prop = 'nil',
    --                 Offsets = {
    --                     First = 0.0,
    --                     Second = 0.0,
    --                     Third = -0.01,
    --                     Four = 90.0,
    --                     Five = 0.0,
    --                     Six = 0.0
    --                 }
    --             }
    --         },
    --         [5] = {
    --             TaskName = "Cajas de agarre",
    --             TaskLoc = {
    --                 Loc = vector3(1782.3448486328, 2594.396484375,
    --                               45.797836303711),
    --                 Heading = 273.6
    --             },
    --             Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
    --             Time = 5,
    --             TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
    --             MarkNum = 20,
    --             MarkColor = {r = 229, g = 235, b = 52},
    --             MarkSize = {x = 0.5, y = 0.5, z = 0.3},
    --             AttachItem = {
    --                 Attach = false,
    --                 Prop = 'nil',
    --                 Offsets = {
    --                     First = 0.0,
    --                     Second = 0.0,
    --                     Third = -0.01,
    --                     Four = 90.0,
    --                     Five = 0.0,
    --                     Six = 0.0
    --                 }
    --             },
    --             CarryItem = {
    --                 Attach = true,
    --                 Prop = 'ng_proc_food_burg02a',
    --                 Offsets = {
    --                     First = 0.0,
    --                     Second = 0.0,
    --                     Third = -0.01,
    --                     Four = 90.0,
    --                     Five = 0.0,
    --                     Six = 0.0
    --                 }
    --             }
    --         },
    --         [6] = {
    --             TaskName = "Establecer cuadros hacia abajo",
    --             TaskLoc = {
    --                 Loc = vector3(1779.2886962891, 2593.552734375,
    --                               45.797836303711),
    --                 Heading = 180.42
    --             },
    --             Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
    --             Time = 5,
    --             TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
    --             MarkNum = 20,
    --             MarkColor = {r = 229, g = 235, b = 52},
    --             MarkSize = {x = 0.5, y = 0.5, z = 0.3},
    --             AttachItem = {
    --                 Attach = false,
    --                 Prop = 'nil',
    --                 Offsets = {
    --                     First = 0.0,
    --                     Second = 0.0,
    --                     Third = -0.01,
    --                     Four = 90.0,
    --                     Five = 0.0,
    --                     Six = 0.0
    --                 }
    --             },
    --             CarryItem = {
    --                 Attach = false,
    --                 Prop = 'nil',
    --                 Offsets = {
    --                     First = 0.0,
    --                     Second = 0.0,
    --                     Third = -0.01,
    --                     Four = 90.0,
    --                     Five = 0.0,
    --                     Six = 0.0
    --                 }
    --             }
    --         },
    --         [7] = {
    --             TaskName = "Coge comida cocinada",
    --             TaskLoc = {
    --                 Loc = vector3(1777.8962402344, 2597.3732910156,
    --                               45.797821044922),
    --                 Heading = 267.45
    --             },
    --             Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
    --             Time = 5,
    --             TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
    --             MarkNum = 20,
    --             MarkColor = {r = 229, g = 235, b = 52},
    --             MarkSize = {x = 0.5, y = 0.5, z = 0.3},
    --             AttachItem = {
    --                 Attach = false,
    --                 Prop = 'nil',
    --                 Offsets = {
    --                     First = 0.0,
    --                     Second = 0.0,
    --                     Third = -0.01,
    --                     Four = 90.0,
    --                     Five = 0.0,
    --                     Six = 0.0
    --                 }
    --             },
    --             CarryItem = {
    --                 Attach = true,
    --                 Prop = 'prop_copper_pan',
    --                 Offsets = {
    --                     First = 0.0,
    --                     Second = 0.0,
    --                     Third = -0.01,
    --                     Four = 90.0,
    --                     Five = 0.0,
    --                     Six = 0.0
    --                 }
    --             }
    --         },
    --         [8] = {
    --             TaskName = "Coloque los alimentos cocinados",
    --             TaskLoc = {
    --                 Loc = vector3(1778.5102539062, 2592.2087402344,
    --                               45.797821044922),
    --                 Heading = 359.12
    --             },
    --             Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
    --             Time = 5,
    --             TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
    --             MarkNum = 20,
    --             MarkColor = {r = 229, g = 235, b = 52},
    --             MarkSize = {x = 0.5, y = 0.5, z = 0.3},
    --             AttachItem = {
    --                 Attach = false,
    --                 Prop = 'nil',
    --                 Offsets = {
    --                     First = 0.0,
    --                     Second = 0.0,
    --                     Third = -0.01,
    --                     Four = 90.0,
    --                     Five = 0.0,
    --                     Six = 0.0
    --                 }
    --             },
    --             CarryItem = {
    --                 Attach = false,
    --                 Prop = 'nil',
    --                 Offsets = {
    --                     First = 0.0,
    --                     Second = 0.0,
    --                     Third = -0.01,
    --                     Four = 90.0,
    --                     Five = 0.0,
    --                     Six = 0.0
    --                 }
    --             }
    --         },
    --         [9] = {
    --             TaskName = "Caja de comida",
    --             TaskLoc = {
    --                 Loc = vector3(1779.1472167969, 2593.5998535156,
    --                               45.797821044922),
    --                 Heading = 184.67
    --             },
    --             Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
    --             Time = 10,
    --             TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
    --             MarkNum = 20,
    --             MarkColor = {r = 229, g = 235, b = 52},
    --             MarkSize = {x = 0.5, y = 0.5, z = 0.3},
    --             AttachItem = {
    --                 Attach = false,
    --                 Prop = 'nil',
    --                 Offsets = {
    --                     First = 0.0,
    --                     Second = 0.0,
    --                     Third = -0.01,
    --                     Four = 90.0,
    --                     Five = 0.0,
    --                     Six = 0.0
    --                 }
    --             },
    --             CarryItem = {
    --                 Attach = true,
    --                 Prop = 'ng_proc_food_burg02a',
    --                 Offsets = {
    --                     First = 0.0,
    --                     Second = 0.0,
    --                     Third = -0.01,
    --                     Four = 90.0,
    --                     Five = 0.0,
    --                     Six = 0.0
    --                 }
    --             }
    --         },
    --         [10] = {
    --             TaskName = "Plato De Comida",
    --             TaskLoc = {
    --                 Loc = vector3(1779.4445800781, 2592.0959472656,
    --                               45.797821044922),
    --                 Heading = 355.66
    --             },
    --             Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
    --             Time = 10,
    --             TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
    --             MarkNum = 20,
    --             MarkColor = {r = 229, g = 235, b = 52},
    --             MarkSize = {x = 0.5, y = 0.5, z = 0.3},
    --             AttachItem = {
    --                 Attach = false,
    --                 Prop = 'nil',
    --                 Offsets = {
    --                     First = 0.0,
    --                     Second = 0.0,
    --                     Third = -0.01,
    --                     Four = 90.0,
    --                     Five = 0.0,
    --                     Six = 0.0
    --                 }
    --             },
    --             CarryItem = {
    --                 Attach = true,
    --                 Prop = 'prop_food_bs_tray_02',
    --                 Offsets = {
    --                     First = 0.0,
    --                     Second = 0.0,
    --                     Third = -0.01,
    --                     Four = 90.0,
    --                     Five = 0.0,
    --                     Six = 0.0
    --                 }
    --             }
    --         },
    --         [11] = {
    --             TaskName = "Repartir comida",
    --             TaskLoc = {
    --                 Loc = vector3(1779.4532470703, 2591.4274902344,
    --                               45.797821044922),
    --                 Heading = 176.83
    --             },
    --             Anim = {
    --                 Dict = 'anim@amb@clubhouse@bar@drink@idle_a',
    --                 AnimName = 'idle_a_bartender'
    --             },
    --             Time = 10,
    --             TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
    --             MarkNum = 20,
    --             MarkColor = {r = 229, g = 235, b = 52},
    --             MarkSize = {x = 0.5, y = 0.5, z = 0.3},
    --             AttachItem = {
    --                 Attach = false,
    --                 Prop = 'nil',
    --                 Offsets = {
    --                     First = 0.0,
    --                     Second = 0.0,
    --                     Third = -0.01,
    --                     Four = 90.0,
    --                     Five = 0.0,
    --                     Six = 0.0
    --                 }
    --             },
    --             CarryItem = {
    --                 Attach = false,
    --                 Prop = 'nil',
    --                 Offsets = {
    --                     First = 0.0,
    --                     Second = 0.0,
    --                     Third = -0.01,
    --                     Four = 90.0,
    --                     Five = 0.0,
    --                     Six = 0.0
    --                 }
    --             }
    --         }
    --     }
    -- },
    [4] = {
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
                TaskLoc = {
                    Loc = vector3(1704.4982910156, 2551.7905273438,
                                  45.564895629883),
                    Heading = 91.44
                },
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'hei_prop_heist_binbag',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [2] = {
                TaskName = "Tirar basura",
                TaskLoc = {
                    Loc = vector3(1622.4766845703, 2615.7399902344,
                                  45.564853668213),
                    Heading = 192.76
                },
                Anim = {Dict = 'amb@prop_human_bum_bin@base', AnimName = 'base'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [3] = {
                TaskName = "Agarra la basura",
                TaskLoc = {
                    Loc = vector3(1700.7912597656, 2555.5249023438,
                                  45.56489944458),
                    Heading = 188.0
                },
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'hei_prop_heist_binbag',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [4] = {
                TaskName = "Tirar basura",
                TaskLoc = {
                    Loc = vector3(1622.4766845703, 2615.7399902344,
                                  45.564853668213),
                    Heading = 192.76
                },
                Anim = {Dict = 'amb@prop_human_bum_bin@base', AnimName = 'base'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [5] = {
                TaskName = "Agarra la basura",
                TaskLoc = {
                    Loc = vector3(1719.0423583984, 2501.5693359375,
                                  45.564853668213),
                    Heading = 275.89
                },
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'hei_prop_heist_binbag',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [6] = {
                TaskName = "Tirar basura",
                TaskLoc = {
                    Loc = vector3(1622.4766845703, 2615.7399902344,
                                  45.564853668213),
                    Heading = 192.76
                },
                Anim = {Dict = 'amb@prop_human_bum_bin@base', AnimName = 'base'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [7] = {
                TaskName = "Agarra la basura",
                TaskLoc = {
                    Loc = vector3(1719.6976318359, 2503.8447265625,
                                  45.564853668213),
                    Heading = 274.05
                },
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = true,
                    Prop = 'hei_prop_heist_binbag',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [8] = {
                TaskName = "Tirar basura",
                TaskLoc = {
                    Loc = vector3(1622.4766845703, 2615.7399902344,
                                  45.564853668213),
                    Heading = 192.76
                },
                Anim = {Dict = 'amb@prop_human_bum_bin@base', AnimName = 'base'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [9] = {
                TaskName = "Coge bolsas vacías",
                TaskLoc = {
                    Loc = vector3(1778.1514892578, 2617.6296386719,
                                  50.549797058105),
                    Heading = 299.56
                },
                Anim = {Dict = 'amb@prop_human_bum_bin@base', AnimName = 'base'},
                Time = 10,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [10] = {
                TaskName = "Poner la bolsa de basura",
                TaskLoc = {
                    Loc = vector3(1704.4982910156, 2551.7905273438,
                                  45.564895629883),
                    Heading = 91.44
                },
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [11] = {
                TaskName = "Poner la bolsa de basura",
                TaskLoc = {
                    Loc = vector3(1700.7912597656, 2555.5249023438,
                                  45.56489944458),
                    Heading = 188.0
                },
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [12] = {
                TaskName = "Poner la bolsa de basura",
                TaskLoc = {
                    Loc = vector3(1719.0423583984, 2501.5693359375,
                                  45.564853668213),
                    Heading = 275.89
                },
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            },
            [13] = {
                TaskName = "Poner la bolsa de basura",
                TaskLoc = {
                    Loc = vector3(1719.6976318359, 2503.8447265625,
                                  45.564853668213),
                    Heading = 274.05
                },
                Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
                Time = 5,
                TBlip = {Spawn = true, Sprite = 162, Color = 46, Size = 0.7},
                MarkNum = 20,
                MarkColor = {r = 167, g = 66, b = 245},
                MarkSize = {x = 0.5, y = 0.5, z = 0.3},
                AttachItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                },
                CarryItem = {
                    Attach = false,
                    Prop = 'nil',
                    Offsets = {
                        First = 0.0,
                        Second = 0.0,
                        Third = -0.01,
                        Four = 90.0,
                        Five = 0.0,
                        Six = 0.0
                    }
                }
            }
        }
    }
}

-- Ajustes activos del trabajo 2: limpieza de ropa.
do
    local startTask = {
        TaskName = 'Agarra la ropa sucia',
        TaskLoc = {
            Loc = vector3(4073.8359, 54.1713, 18.7869),
            Heading = 355.8455
        },
        TBlip = {Spawn = true, Sprite = 162, Color = 3, Size = 0.7},
        Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'},
        Time = 10,
        AttachItem = {Attach = false},
        CarryItem = {
            Attach = true,
            Prop = 'bkr_prop_fakeid_binbag_01',
            Offsets = {
                First = 0.0,
                Second = -0.13,
                Third = -0.2,
                Four = 0.0,
                Five = 0.0,
                Six = 0.0
            }
        }
    }
    local step = {
        TaskName = 'Tarea de lavandería',
        AttachItem = {Attach = false},
        CarryItem = {Attach = false}
    }
    step.Anim = {Dict = 'mini@repair', AnimName = 'fixing_a_ped'}
    step.Time = 10
    step.TaskLoc = startTask.TaskLoc
    step.TBlip = startTask.TBlip
    Config.JobOptions[2].Tasks = {
        startTask, step, startTask, step, startTask, step, startTask, step,
        step, step, step, step, step, step, step, step, step, step, step, step,
        step
    }
end

-- Trabajo 4: limpiar basura.
do
    local tasks = {}
    for i = 1, 4 do
        tasks[#tasks + 1] = {
            TaskName = 'Recoger bolsa de basura',
            TaskLoc = {Loc = Config.GarbageBagLocs[i], Heading = 0.0},
            TBlip = {Spawn = true, Sprite = 162, Color = 2, Size = 0.7},
            Anim = {Dict = 'custom@pickfromground', AnimName = 'pickfromground'},
            Time = 10,
            AttachItem = {Attach = false},
            CarryItem = {
                Attach = true,
                Prop = 'prop_rub_binbag_06',
                Offsets = {
                    First = 0.0,
                    Second = 0.0400,
                    Third = -0.3,
                    Four = 0.0,
                    Five = 0.0,
                    Six = 0.0
                }
            }
        }
        tasks[#tasks + 1] = {
            TaskName = 'Dejar la basura',
            TaskLoc = Config.GarbageDumpsterLoc,
            TBlip = {Spawn = true, Sprite = 162, Color = 2, Size = 0.7},
            Anim = Config.GarbageDumpsterAnim,
            Time = Config.GarbageDumpsterAnim.Time,
            AttachItem = {Attach = false},
            CarryItem = {Attach = false}
        }
    end
    Config.JobOptions[4] = {
        Name = 'Limpiar basura',
        TimeRemove = 10,
        StealChance = 2,
        StealItems = {},
        Tasks = tasks
    }
end

-- Configuraciones de uniformes
-- ============================================================================
-- 6. UNIFORMES Y CAMBIOS DE ROPA
-- ============================================================================
Config.Uniforms = { -- Ropa de los uniformes
    male = {
        ['tshirt_1'] = 15,
        ['tshirt_2'] = 0,
        ['torso_1'] = 146,
        ['torso_2'] = 0,
        ['decals_1'] = 0,
        ['decals_2'] = 0,
        ['arms'] = 0,
        ['pants_1'] = 5,
        ['pants_2'] = 7,
        ['shoes_1'] = 6,
        ['shoes_2'] = 0,
        ['mask_1'] = 0,
        ['mask_2'] = 0,
        ['bproof_1'] = 0,
        ['bproof_2'] = 0,
        ['chain_1'] = 0,
        ['chain_2'] = 0,
        ['helmet_1'] = -1,
        ['helmet_2'] = 0,
        ['glasses_1'] = 0,
        ['glasses_2'] = 0
    },
    female = {
        ['tshirt_1'] = 15,
        ['tshirt_2'] = 0,
        ['torso_1'] = 118,
        ['torso_2'] = 0,
        ['decals_1'] = 0,
        ['decals_2'] = 0,
        ['arms'] = 4,
        ['pants_1'] = 4,
        ['pants_2'] = 5,
        ['shoes_1'] = 16,
        ['shoes_2'] = 0,
        ['mask_1'] = 0,
        ['mask_2'] = 0,
        ['bproof_1'] = 0,
        ['bproof_2'] = 0,
        ['chain_1'] = 0,
        ['chain_2'] = 0,
        ['helmet_1'] = -1,
        ['helmet_2'] = 0,
        ['glasses_1'] = 0,
        ['glasses_2'] = 0
    }
}

-- --Configuraciones de celdas
-- Config.Cells = { --Todas las celdas de la prisión
--     [1] = {
--         SpawnLoc = {Loc = vector3(), Heading = 173.5104}, --Ubicación de aparición (normalmente en el centro de la celda)
--         InvLoc = {Loc = vector3(), Heading = 267.5397}, --Ubicación del inventario o de la cama
--         BreakLoc = {Loc = vector3(8), Heading = 1.6232}, --Ubicación de escape
--         ExitLoc = {Loc = vector3(), Heading = 3.5825} --Salida después de arrastrarse durante el escape (normalmente fuera del edificio)
--     },
-- }

-- Configuraciones de aislamiento
-- ============================================================================
-- 7. AISLAMIENTO Y BLOQUEO
-- ============================================================================
Config.Solitary = true -- Si quieres que haya aislamiento

Config.Sol4Run = true -- Si quieres enviar a aislamiento a quienes escapen sin usar el recurso de prisión (por ejemplo, usando emotes para atravesar vallas y otros obstáculos)
Config.SolRunTime = 1 -- Tiempo en minutos para la opción anterior

Config.FailBreakToSol = true -- Si quieres enviar a aislamiento a quienes no escapen a tiempo
Config.SolBreakTime = 1 -- Tiempo en minutos para la opción anterior

Config.Sol4Lock = false -- Si quieres enviar a aislamiento a quienes intenten salir de su celda durante el bloqueo
Config.SolLockTime = 1 -- Tiempo en minutos para la opción anterior

Config.Sol4Kill = true -- Si quieres enviar a aislamiento a quienes maten a alguien
Config.SolKillTime = 1 -- Tiempo en minutos para la opción anterior

-- Config.SolCells = { --Todas las ubicaciones de aislamiento
--     [1] = {Loc = vector3(3909.3259, 32.1250, 27.4285), Heading = 173.8917},
--     -- [2] = {Loc = vector3(1765.9827880859, 2594.2705078125, 50.54963684082), Heading = 93.12},
--     -- [3] = {Loc = vector3(1765.9401855469, 2591.3493652344, 50.549640655518), Heading = 89.13},
--     -- [4] = {Loc = vector3(1765.7937011719, 2588.3737792969, 50.549644470215), Heading = 93.71},
--     -- [5] = {Loc = vector3(1762.1220703125, 2588.2312011719, 50.549640655518), Heading = 271.49},
--     -- [6] = {Loc = vector3(1762.0230712891, 2591.0876464844, 50.549640655518), Heading = 269.32},
--     -- [7] = {Loc = vector3(1762.1560058594, 2594.0744628906, 50.549644470215), Heading = 268.63},
--     -- [8] = {Loc = vector3(1761.8892822266, 2597.021484375, 50.549640655518), Heading = 278.27}
-- }

-- Configuraciones de reanimación
-- ============================================================================
-- 8. HOSPITAL Y REANIMACION
-- ============================================================================
Config.Hospital = true -- Si quieres que haya hospital
Config.DoctorPed = 's_m_m_doctor_01' -- Personaje médico del hospital
Config.CheckUpTime = 10 -- Tiempo necesario para revisar a un prisionero (en segundos)
Config.BedLocs = {
    [1] = {
        SpawnLoc = {
            Loc = vector3(4040.98657, -2.148099, 19.8),
            Heading = 90.0
        }, -- Ubicación de aparición del médico
        DoctorSpawn = {
            Loc = vector3(4037.3699, -3.6748, 18.7874),
            Heading = 12.5144
        }, -- Ubicación de aparición del médico
        DocCheck = {
            Loc = vector3(4040.9111, -3.0005, 18.7874),
            Heading = 355.8610
        }, -- Ubicación a la que camina el médico para revisar
        DocWalkTime = 7 -- Tiempo que debe tardar el médico en llegar (en segundos)
    },
    [2] = {
        SpawnLoc = {Loc = vector3(4043.25586, -8.693617, 19.8), Heading = 90.0},
        DoctorSpawn = {
            Loc = vector3(4039.7917, -6.7746, 18.7874),
            Heading = 183.0027
        },
        DocCheck = {
            Loc = vector3(4043.0627, -7.7115, 18.7874),
            Heading = 179.7846
        },
        DocWalkTime = 7
    },
    [3] = {
        SpawnLoc = {Loc = vector3(4046.26953, -8.089871, 19.8), Heading = -90.0},
        DoctorSpawn = {
            Loc = vector3(4050.0994, -6.8582, 18.7874),
            Heading = 358.5315
        },
        DocCheck = {
            Loc = vector3(4046.3774, -7.2284, 18.7874),
            Heading = 178.1526
        },
        DocWalkTime = 7
    },
    [4] = {
        SpawnLoc = {Loc = vector3(4048.832, -1.75661325, 19.8), Heading = -90.0},
        DoctorSpawn = {
            Loc = vector3(4052.2546, -3.3960, 18.7874),
            Heading = 8.0058
        },
        DocCheck = {
            Loc = vector3(4049.2009, -2.6267, 18.7874),
            Heading = 359.7542
        },
        DocWalkTime = 7
    }
}

-- Configuraciones de escape
-- ============================================================================
-- 9. ESCAPE Y TORRES DE VIGILANCIA
-- ============================================================================
Config.Breakout = true -- Si los prisioneros pueden escapar de la prisión
Config.BreakHole = 2 -- Cantidad de excavaciones exitosas necesarias

Config.BreakoutTime = 120 -- Tiempo disponible para escapar antes de ser atrapado (en segundos)


Config.SeeBreakDist = 15 -- Distancia necesaria para ver los marcadores
Config.BreakBlips = {Spawn = true, Sprite = 186, Color = 49, Size = 0.5} -- Indicadores de todas las ubicaciones de escape y corte

Config.BreakLocs =
    { -- Todas las ubicaciones de corte y excavación del escape (StartLoc es donde se realiza la animación y aparece el marcador; ExitLoc es donde se teletransporta al jugador; ExitFence solo es true en la última salida antes de abandonar la prisión)
        [1] = {
            StartLoc = {
                Loc = vector3(3909.3064, 32.0933, 23.8882),
                Heading = 175.1696
            },
            ExitLoc = {
                Loc = vector3(3898.6121, 44.5316, 22.2277),
                Heading = 36.8051
            },
            ExitFence = false
        }
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

Config.RoomTools =
    { -- Todas las herramientas para celdas y ubicaciones de salida
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
        [4] = {Name = "Ácido", Item = 'hd_acid', Time = 20, Percent = 8},
        [5] = {
            Name = "Martillo Miniatura",
            Item = 'hd_minih',
            Time = 25,
            Percent = 9
        }
    }

Config.FenceTool =
    { -- Herramientas para cercas que no son ubicaciones de salida
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
        [3] = {Name = "Ácido", Item = 'hd_acid', Time = 20, Percent = 9},
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

Config.WatchMarkNum = 1 -- Número del marcador de la torre de vigilancia
Config.WatchMarkColor = {r = 255, g = 0, b = 0} -- Color del marcador de la torre de vigilancia

Config.WatchBlip = {Spawn = true, Sprite = 629, Color = 1, ConeColor = 0, ConeAlertColor = 6, Size = 0.7} -- Configuración del indicador de la cámara CCTV
Config.MaxWatchDist = 150 -- Distancia necesaria para escapar por completo
Config.FenceEscapePoints = {
    { type = 'internal', coords = vector3(3981.978, 64.45724, 12.9470), heading = 349.7489 },
    { type = 'internal', coords = vector3(3837.69458, 51.7038956, 16.7824), heading = 101.3247 },
    { type = 'internal', coords = vector3(3838.465, 46.06752, 16.7838), heading = 101.9936 },
    { type = 'internal', coords = vector3(3843.57959, 9.834607, 15.9389), heading = 192.3398 },
    { type = 'internal', coords = vector3(3849.36841, 0.06938955, 16.7824), heading = 180.2271 },
    { type = 'external', coords = vector3(3976.97778, 69.66262, 13.2886), heading = 348.8672 },
    { type = 'external', coords = vector3(3833.13574, 83.02484, 16.7824), heading = 2.0993 },
    { type = 'external', coords = vector3(3827.314, 82.3715744, 16.7824), heading = 2.0993 },
    { type = 'external', coords = vector3(3813.86548, -21.998167, 6.7070), heading = 166.1262 },
    { type = 'external', coords = vector3(3819.22046, -23.7624683, 6.7070), heading = 166.1262 },
    { type = 'external', coords = vector3(3902.096, -5.95140362, 6.9143), heading = 268.3939 },
    { type = 'external', coords = vector3(3995.9668, -8.410812, 18.4995), heading = 176.0347 },
    { type = 'external', coords = vector3(4001.72217, -8.238596, 18.4995), heading = 176.0347 },
    { type = 'external', coords = vector3(4012.23364, -10.0916424, 19.1819), heading = 175.5624 },
    { type = 'external', coords = vector3(4017.82813, -11.0751743, 19.1820), heading = 173.3065 },
    { type = 'external', coords = vector3(4093.337, 38.43858, 19.9044), heading = 283.1995 },
}
Config.SeeWatchDist = 75 -- Distancia necesaria para ver el círculo 3D
Config.WatchCameras = { -- Ubicaciones de las cámaras
    [1] = vector4(3872.864, -31.87372, 35.5, 350.0),
    [2] = vector4(3838.44263, -17.7937088, 35.5, 180.0),
    [3] = vector4(3817.32446, 11.1535282, 35.5, 20.0),
    [4] = vector4(3922.08838, -6.68391228, 35.5, 108.0),
    [5] = vector4(4054.73584, -0.564636946, 35.5, 45.0),
    [6] = vector4(4065.01123, 28.1750088, 35.5, 0.0),--4064.3853, 27.1188, 18.7589, 319.1920
    [7] = vector4(3968.9834, 32.069313, 35.5, 90.0),
    [8] = vector4(3944.25049, 51.9409561, 35.5, 90),
    [9] = vector4(3967.12817, 54.20391, 35.5, 288.0),
    [10] = vector4(3941.412, 18.7877922, 35.5, 200.0),
    [11] = vector4(4023.2395, 29.6116, 48.6724, 119.4506), 
    [12] = vector4(3815.35645, 68.37755, 21.3922729, 45.0),
    [13] = vector4(4064.81934, -20.7471161, 26.2662811, 220.0),  
    [14] = vector4(3983.90454, 65.72903, 16.5224037, 320.0),  
    [15] = vector4(3978.74829, -17.6242466, 18.6436033, 150.0)  
    
    
    
}

-- Heading inicial independiente por cámara; omite una entrada para usar el heading automático
Config.WatchCameraDirections = {
    [1] = -1,
    [2] = -1,
    [3] = 1,
    [4] = 1,
    [5] = -1,
    [6] = 1,
    [7] = -1,
    [8] = 1,
    [9] = 1,
    [10] = 1,
    [11] = 1,
    [12] = -1,
    [13] = -1,
    [13] = -1,
    [14] = -1,
    [14] = 1
}

Config.WatchCameraSweepSpeed = 10.0
Config.WatchCameraSweepAngle = 110.0
Config.WatchCameraRange = 55.0
Config.WatchCameraFov = 65.0
Config.WatchCameraConeWidth = 0.5
Config.WatchCameraConeLength = 53.0

-- Configuraciones de duchas
-- ============================================================================
-- 10. DUCHAS
-- ============================================================================
Config.Showers = true -- Si quieres que haya duchas en la prisión
Config.ShowerLoc = {
    Loc = vector3(3909.3359, 41.9588, 23.8882),
    Heading = 261.21
} -- Cambiar la ubicación de las duchas
Config.ShowerBlip = {Spawn = true, Sprite = 272, Color = 0, Size = 0.9} -- Configuración del indicador de las duchas

Config.ShowMarkNum = 21 -- Número del marcador 3D de las duchas
Config.ShowMarkColor = {r = 50, g = 109, b = 168} -- Color del marcador 3D de las duchas
Config.ShowMarkSize = {x = 0.5, y = 0.5, z = 0.5} -- Tamaño del marcador 3D de las duchas

Config.GetReadyTime = 5 -- Tiempo necesario para cambiarse
Config.ShowerFullDist = 7 -- Distancia necesaria para ver el marcador 3D
Config.MaxDistShower = 20 -- Distancia máxima antes de cancelar la ducha

Config.ShowerLocs = { -- Todas las ubicaciones de las duchas
    [1] = vector3(3907.3303, 37.1681, 23.8882),
    [2] = vector3(3907.2927, 38.3814, 23.8882),

    [3] = vector3(3907.3420, 39.3693, 23.8882),
    [4] = vector3(3907.3760, 40.5676, 23.8882),

    [5] = vector3(3906.3972, 37.5754, 23.8882),
    [6] = vector3(3906.4219, 38.3923, 23.8882),

    [7] = vector3(3906.4536, 39.7863, 23.8882),
    [8] = vector3(3906.4224, 40.4748, 23.8882)

}

Config.ShowerFit =
    { -- Ropa para ducharse (el personaje debe estar desnudo o usar pantalones)
        male = {
            ['tshirt_1'] = 15,
            ['tshirt_2'] = 0,
            ['torso_1'] = 15,
            ['torso_2'] = 0,
            ['decals_1'] = 0,
            ['decals_2'] = 0,
            ['arms'] = 15,
            ['pants_1'] = 21,
            ['pants_2'] = 0,
            ['shoes_1'] = 34,
            ['shoes_2'] = 0,
            ['mask_1'] = 0,
            ['mask_2'] = 0,
            ['bproof_1'] = 0,
            ['bproof_2'] = 0,
            ['chain_1'] = 0,
            ['chain_2'] = 0,
            ['helmet_1'] = -1,
            ['helmet_2'] = 0,
            ['glasses_1'] = 0,
            ['glasses_2'] = 0
        },
        female = {
            ['tshirt_1'] = 15,
            ['tshirt_2'] = 0,
            ['torso_1'] = 15,
            ['torso_2'] = 0,
            ['decals_1'] = 0,
            ['decals_2'] = 0,
            ['arms'] = 15,
            ['pants_1'] = 15,
            ['pants_2'] = 0,
            ['shoes_1'] = 35,
            ['shoes_2'] = 0,
            ['mask_1'] = 0,
            ['mask_2'] = 0,
            ['bproof_1'] = 0,
            ['bproof_2'] = 0,
            ['chain_1'] = 0,
            ['chain_2'] = 0,
            ['helmet_1'] = -1,
            ['helmet_2'] = 0,
            ['glasses_1'] = 0,
            ['glasses_2'] = 0
        }
    }

Config.JobIntroCam1 = vector3(3916.00928, 26.9864845, 25.4628868)
Config.JobIntroCam2 = vector3(3915.631, 22.7850742, 23.87154)
Config.JobIntroCamHeading = 173.9453

Config.FoodIntroCenter = vector3(3926.05786, 30.2985, 24.194)
Config.FoodIntroRadius = 0.1
Config.FoodIntroAngle = 45.0
Config.FoodIntroDirection = 1

Config.SolIntroCam1 = vector3(3884.96, 27.3138256, 33.2573948)
Config.SolIntroCam2 = vector3(3901.6377, 25.8523674, 28.6279068)
Config.SolIntroCamHeading = 262.7419

Config.ShowerIntroCenter = vector3(3907.371, 39.12199, 23.887785)
Config.ShowerIntroRadius = 3.0
Config.ShowerIntroAngle = 90.0
Config.ShowerIntroDirection = -1
Config.ShowerIntroStartAngle = 40.0

Config.ItemIntroCam1 = vector3(3865.28223, -19.403944, 7.0)
Config.ItemIntroCam2 = vector3(3870.54, -23.69, 8.39)
Config.ItemIntroHeading1 = 4.6474
Config.ItemIntroHeading2 = 43.1045

Config.FinalHeliStart = vector3(3711.5129, 31.0118, 44.5234)
Config.FinalHeliStartHeading = 273.8299
Config.FinalHeliLanding = vector3(3810.4983, 31.9246, 20.1497)
Config.FinalHeliLandingHeading = 270.2020
Config.FinalOrbitCenter = vector3(3810.63916, 32.40902, 14.8724775)
Config.FinalOrbitRadius = 15.0
Config.FinalOrbitHeight = 20.0
Config.FinalOrbitAngle = 45.0
Config.FinalOrbitDirection = -1
Config.FinalHeliDuration = 8
Config.FinalHeliTouchdownZ = 18.5
Config.FinalHeliDescentDuration = 4

-- ============================================================================
-- 12. UBICACIONES FINALES: CELDAS Y AISLAMIENTO
-- ============================================================================
Config.Cells = {
    [1] = {
        SpawnLoc = {
            Loc = vector3(3909.2060, 30.66959, 23.80868),
            Heading = 185.9424
        },
        BreakLoc = {
            Loc = vector3(3909.53979, 33.5090637, 22.89),
            Heading = -6.2
        },
        InvLoc = {
            Loc = vector3(3909.9010, 32.44114, 23.64975),
            Heading = 274.6745
        },
        ExitLoc = {Loc = vector3(3910.3650, 43.62182, 21.85121), Heading = 3.0}
    },
    [2] = {
        SpawnLoc = {
            Loc = vector3(3905.6070, 30.9720, 23.80868),
            Heading = 185.9424
        },
        BreakLoc = {
            Loc = vector3(3905.9640, 33.80193, 22.89),
            Heading = -6.2
        },
        InvLoc = {
            Loc = vector3(3906.3030, 32.74354, 23.64975),
            Heading = 274.6745
        },
        ExitLoc = {Loc = vector3(3906.7650, 43.92423, 21.85121), Heading = 3.0}
    },
    [3] = {
        SpawnLoc = {
            Loc = vector3(3898.5020, 31.58108, 23.80868),
            Heading = 185.9424
        },
        BreakLoc = {
            Loc = vector3(3898.8590, 34.41101, 22.89),
            Heading = -6.2
        },
        InvLoc = {
            Loc = vector3(3899.1980, 33.35262, 23.64975),
            Heading = 274.6745
        },
        ExitLoc = {Loc = vector3(3899.6610, 44.53331, 21.85121), Heading = 3.0}
    },
    [4] = {
        SpawnLoc = {
            Loc = vector3(3895.0430, 31.86498, 23.80868),
            Heading = 185.9424
        },
        BreakLoc = {
            Loc = vector3(3895.4010, 34.69491, 22.89),
            Heading = -6.2
        },
        InvLoc = {
            Loc = vector3(3895.7390, 33.63652, 23.64975),
            Heading = 274.6745
        },
        ExitLoc = {Loc = vector3(3896.2020, 44.81721, 21.85121), Heading = 3.0}
    },
    [5] = {
        SpawnLoc = {
            Loc = vector3(3909.2820, 30.66959, 27.34492),
            Heading = 185.9424
        },
        BreakLoc = {
            Loc = vector3(3909.6390, 33.49953,  26.4273949),
            Heading = -6.2
        },
        InvLoc = {
            Loc = vector3(3909.9780, 32.44114, 27.18599),
            Heading = 274.6745
        },
        ExitLoc = {Loc = vector3(3910.4410, 43.62182, 21.83060), Heading = 3.0}
    },
    [6] = {
        SpawnLoc = {
            Loc = vector3(3905.6830, 30.97200, 27.34492),
            Heading = 185.9424
        },
        BreakLoc = {
            Loc = vector3(3906.0400, 33.80193,  26.4273949),
            Heading = -6.2
        },
        InvLoc = {
            Loc = vector3(3906.3790, 32.74354, 27.18599),
            Heading = 274.6745
        },
        ExitLoc = {Loc = vector3(3906.8420, 43.92423, 21.83060), Heading = 3.0}
    },
    [7] = {
        SpawnLoc = {
            Loc = vector3(3898.5790, 31.58108, 27.34492),
            Heading = 185.9424
        },
        BreakLoc = {
            Loc = vector3(3898.9360, 34.41101, 26.4273949),
            Heading = -6.2
        },
        InvLoc = {
            Loc = vector3(3899.2740, 33.35262, 27.18599),
            Heading = 274.6745
        },
        ExitLoc = {Loc = vector3(3899.7370, 44.53331, 21.83060), Heading = 3.0}
    },
    [8] = {
        SpawnLoc = {
            Loc = vector3(3895.1200, 31.86498, 27.34492),
            Heading = 185.9424
        },
        BreakLoc = {
            Loc = vector3(3895.4770, 34.69491, 26.4273949),
            Heading = -6.2
        },
        InvLoc = {
            Loc = vector3(3895.8160, 33.63652, 27.18599),
            Heading = 274.6745
        },
        ExitLoc = {Loc = vector3(3896.2790, 44.81721, 21.83060), Heading = 3.0}
    },
    [9] = {
        SpawnLoc = {
            Loc = vector3(3890.7040, 21.07272, 27.36400),
            Heading = 5.7362
        },
        BreakLoc = {
            Loc = vector3(3890.3580, 18.24248, 26.4273949),
            Heading = 175.68
        },
        InvLoc = {
            Loc = vector3(3891.0140, 19.22185, 27.20507),
            Heading = 277.3376
        },
        ExitLoc = {
            Loc = vector3(3889.9260, 14.96824, 20.59464),
            Heading = 182.7938
        }
    },
    [10] = {
        SpawnLoc = {
            Loc = vector3(3894.2000, 20.74822, 27.36400),
            Heading = 5.7362
        },
        BreakLoc = {
            Loc = vector3(3893.8530, 17.91798, 26.4273949),
            Heading = 175.68
        },
        InvLoc = {
            Loc = vector3(3894.5100, 18.89735, 27.20507),
            Heading = 277.3376
        },
        ExitLoc = {
            Loc = vector3(3893.4220, 14.64374, 20.59464),
            Heading = 182.7938
        }
    },
    [11] = {
        SpawnLoc = {
            Loc = vector3(3897.8440, 20.45254, 27.36893),
            Heading = 5.7362
        },
        BreakLoc = {
            Loc = vector3(3897.4980, 17.62230, 26.4273949),
            Heading = 175.68
        },
        InvLoc = {
            Loc = vector3(3898.1550, 18.60167, 27.21000),
            Heading = 277.3376
        },
        ExitLoc = {
            Loc = vector3(3897.0660, 14.34806, 20.59957),
            Heading = 182.7938
        }
    },
    [12] = {
        SpawnLoc = {
            Loc = vector3(3904.6820, 19.88868, 27.36893),
            Heading = 5.7362
        },
        BreakLoc = {
            Loc = vector3(3904.3360, 17.05845, 26.4273949),
            Heading = 175.68
        },
        InvLoc = {
            Loc = vector3(3904.9920, 18.03782, 27.21000),
            Heading = 277.3376
        },
        ExitLoc = {
            Loc = vector3(3903.9040, 13.78421, 20.59957),
            Heading = 182.7938
        }
    },
    [13] = {
        SpawnLoc = {
            Loc = vector3(3890.7040, 21.07272, 23.80782),
            Heading = 5.7362
        },
        BreakLoc = {
            Loc = vector3(3890.3580, 18.24248, 22.89),
            Heading = 175.68
        },
        InvLoc = {
            Loc = vector3(3891.0140, 19.22185, 23.64888),
            Heading = 277.3376
        },
        ExitLoc = {
            Loc = vector3(3889.9260, 14.96824, 20.59060),
            Heading = 182.7938
        }
    },
    [14] = {
        SpawnLoc = {
            Loc = vector3(3894.2000, 20.74822, 23.80782),
            Heading = 5.7362
        },
        BreakLoc = {
            Loc = vector3(3893.8530, 17.91798, 22.89),
            Heading = 175.68
        },
        InvLoc = {
            Loc = vector3(3894.5100, 18.89735, 23.64888),
            Heading = 277.3376
        },
        ExitLoc = {
            Loc = vector3(3893.4220, 14.64374, 20.59060),
            Heading = 182.7938
        }
    },
    [15] = {
        SpawnLoc = {
            Loc = vector3(3898.1610, 20.74822, 23.80782),
            Heading = 5.7362
        },
        BreakLoc = {
            Loc = vector3(3896.8120, 17.71468, 22.89),
            Heading = 175.68
        },
        InvLoc = {
            Loc = vector3(3896.9060, 19.33192, 23.64888),
            Heading = 277.3376
        },
        ExitLoc = {
            Loc = vector3(3897.3830, 14.64374, 20.59060),
            Heading = 182.7938
        }
    },
    [16] = {
        SpawnLoc = {
            Loc = vector3(3905.1440, 19.99402, 23.80782),
            Heading = 5.7362
        },
        BreakLoc = {
            Loc = vector3(3904.7260, 17.06676, 22.89),
            Heading = 175.68
        },
        InvLoc = {
            Loc = vector3(3903.8900, 18.57772, 23.64888),
            Heading = 277.3376
        },
        ExitLoc = {
            Loc = vector3(3904.3660, 13.88954, 20.59060),
            Heading = 182.7938
        }
    },
    [17] = {
        SpawnLoc = {
            Loc = vector3(3908.3290, 19.68439, 23.80782),
            Heading = 5.7362
        },
        BreakLoc = {
            Loc = vector3(3909.3230, 16.66922, 22.89),
            Heading = 175.68
        },
        InvLoc = {
            Loc = vector3(3909.2800, 18.26809, 23.64888),
            Heading = 90.9520
        },
        ExitLoc = {
            Loc = vector3(3907.5510, 13.57991, 20.59060),
            Heading = 182.7938
        }
    },
    [18] = {
        SpawnLoc = {
            Loc = vector3(3908.3290, 19.68439, 27.32648),
            Heading = 5.7362
        },
        BreakLoc = {
            Loc = vector3(3908.0820, 16.66922, 26.4273949),
            Heading = 175.68
        },
        InvLoc = {
            Loc = vector3(3909.2800, 18.26809, 27.16755),
            Heading = 90.9520
        },
        ExitLoc = {
            Loc = vector3(3907.5510, 13.57991, 24.10927),
            Heading = 182.7938
        }
    }
}

Config.SolCells = {
    [1] = {Loc = vector3(4071.8920, 10.77650, 18.67141), Heading = 313.2032},
    [2] = {Loc = vector3(4074.2070, 13.24247, 18.67141), Heading = 313.2032},
    [3] = {Loc = vector3(4076.3390, 15.83901, 18.67141), Heading = 313.2032},
    [4] = {Loc = vector3(4078.6550, 18.30499, 18.67141), Heading = 313.2032},
    [5] = {Loc = vector3(4080.6650, 20.67154, 18.67141), Heading = 313.2032},
    [6] = {Loc = vector3(4082.9810, 23.13752, 18.67141), Heading = 313.2032},
    [7] = {Loc = vector3(4084.9870, 25.45144, 18.67141), Heading = 313.2032},
    [8] = {Loc = vector3(4087.3030, 27.91741, 18.67141), Heading = 313.2032},
    [9] = {Loc = vector3(4089.4080, 30.43169, 18.67141), Heading = 313.2032},
    [10] = {Loc = vector3(4091.7240, 32.89766, 18.67141), Heading = 313.2032}
}

