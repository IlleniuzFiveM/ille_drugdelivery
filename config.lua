Config = {}
-- ille_drugdelivery v1
Config.Timer = 14400 -- Χρόνος σε δευτερόλεπτα μεταξύ των γεγονότων (14400 δευτερόλεπτα = 4 ώρες)
Config.VehicleModel = "speedo" -- Αλλάζετε το μοντέλο του οχήματος σε όποιο όχημα θέλετε
Config.SpawnPoint = { x = 250.99 , y = 3134.65 , z = 40.98 , h = 90.332710266113}
Config.DeliveryPoint = { x = -1312.26 , y = -1262.11 , z = 3.57 }

-- Rewards
Config.MoneyGiven = 50000 
Config.ItemGiven = 'meth'
Config.ItemGivenAmount = 50


-- When Drug Delivery Starts
Config.AdvancedNotification2 = {
    title = "Drug Delivery",
    subject = "Announcement",
    msg = "~g~Drug Delivery started, open your map and find the Drug Delivery",
    iconType = 1,
    icon = "CHAR_LESTER_DEATHWISH"
}

-- When You Enter The Vehicle 
Config.AdvancedNotification = {
    title = "Drug Delivery",
    subject = "Delivery Started",
    msg = "~g~Head to the delivery point and deliver the drugs and get rewards.",
    iconType = 1,
    icon = "CHAR_LESTER_DEATHWISH"
}
