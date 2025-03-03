/mob/living/carbon/metroid
	hud_type = /datum/hud/metroid

/datum/hud/metroid/FinalizeInstantiation(ui_style = 'icons/hud/style/midnight.dmi')
	src.adding = list()

	var/obj/screen/using

	using = new /obj/screen/intent()
	src.adding += using
	action_intent = using

	mymob.client.screen = list()
	mymob.client.screen += src.adding

/mob/living/simple_animal/construct
	hud_type = /datum/hud/construct

/datum/hud/construct/FinalizeInstantiation()
	var/constructtype

	if(istype(mymob,/mob/living/simple_animal/construct/armoured) || istype(mymob,/mob/living/simple_animal/construct/behemoth))
		constructtype = "juggernaut"
	else if(istype(mymob,/mob/living/simple_animal/construct/builder))
		constructtype = "artificer"
	else if(istype(mymob,/mob/living/simple_animal/construct/wraith))
		constructtype = "wraith"
	else if(istype(mymob,/mob/living/simple_animal/construct/harvester))
		constructtype = "harvester"

	if(constructtype)
		mymob.fire = new /obj/screen()
		mymob.fire.icon = 'icons/hud/mob/screen_construct.dmi'
		mymob.fire.icon_state = "fire0"
		mymob.fire.SetName("fire")
		mymob.fire.screen_loc = ui_construct_fire

		mymob.healths = new /obj/screen()
		mymob.healths.icon = 'icons/hud/mob/screen_construct.dmi'
		mymob.healths.icon_state = "[constructtype]_health0"
		mymob.healths.SetName("health")
		mymob.healths.screen_loc = ui_construct_health

		mymob.pullin = new /obj/screen()
		mymob.pullin.icon = 'icons/hud/mob/screen_construct.dmi'
		mymob.pullin.icon_state = "pull0"
		mymob.pullin.SetName("pull")
		mymob.pullin.screen_loc = ui_construct_pull

		mymob.zone_sel = new /obj/screen/zone_sel()
		mymob.zone_sel.icon = 'icons/hud/mob/screen_construct.dmi'
		mymob.zone_sel.overlays.len = 0
		mymob.zone_sel.overlays += image('icons/hud/common/screen_zone_sel.dmi', "[mymob.zone_sel.selecting]")

		mymob.purged = new /obj/screen()
		mymob.purged.icon = 'icons/hud/mob/screen_construct.dmi'
		mymob.purged.icon_state = "purge0"
		mymob.purged.SetName("purged")
		mymob.purged.screen_loc = ui_construct_purge

	mymob.client.screen = list()
	mymob.client.screen += list(mymob.fire, mymob.healths, mymob.pullin, mymob.zone_sel, mymob.purged)

/mob/living/simple_animal/corgi
	hud_type = /datum/hud/corgi

/datum/hud/corgi/FinalizeInstantiation()
	mymob.fire = new /obj/screen()
	mymob.fire.icon = 'icons/hud/mob/screen_corgi.dmi'
	mymob.fire.icon_state = "fire0"
	mymob.fire.name = "fire"
	mymob.fire.screen_loc = ui_fire

	mymob.healths = new /obj/screen()
	mymob.healths.icon = 'icons/hud/mob/screen_corgi.dmi'
	mymob.healths.icon_state = "health0"
	mymob.healths.name = "health"
	mymob.healths.screen_loc = ui_health

	mymob.pullin = new /obj/screen()
	mymob.pullin.icon = 'icons/hud/mob/screen_corgi.dmi'
	mymob.pullin.icon_state = "pull0"
	mymob.pullin.name = "pull"
	mymob.pullin.screen_loc = ui_construct_pull

	mymob.oxygen = new /obj/screen()
	mymob.oxygen.icon = 'icons/hud/mob/screen_corgi.dmi'
	mymob.oxygen.icon_state = "oxy0"
	mymob.oxygen.name = "oxygen"
	mymob.oxygen.screen_loc = ui_oxygen

	mymob.toxin = new /obj/screen()
	mymob.toxin.icon = 'icons/hud/mob/screen_corgi.dmi'
	mymob.toxin.icon_state = "tox0"
	mymob.toxin.name = "toxin"
	mymob.toxin.screen_loc = ui_toxin

	mymob.client.screen = list()
	mymob.client.screen += list(mymob.fire, mymob.healths, mymob.pullin, mymob.oxygen, mymob.toxin)
