ALTER TABLE `players`
    ADD COLUMN IF NOT EXISTS `hdjail_data` LONGTEXT NOT NULL DEFAULT '{"cell":0,"chest":[],"jailtime":0,"items":[],"clothes":[],"job":0,"breaks":0,"soli":0,"jobo":"nil","grade":0}';

-- Qbox jobs and items are configured in qbx_core and ox_inventory.
-- Add the prisoner job and HD items there before starting this resource.
