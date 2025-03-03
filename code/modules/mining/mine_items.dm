/**********************Miner Lockers**************************/

/obj/structure/closet/secure_closet/miner
	name = "shaft miner locker"
	icon_state = "miningsec1"
	icon_closed = "miningsec"
	icon_locked = "miningsec1"
	icon_opened = "miningsecopen"
	icon_broken = "miningsecbroken"
	icon_off = "miningsecoff"
	req_access = list(access_mining)

/obj/structure/closet/secure_closet/miner/New()
	..()
	sleep(2)
	if(prob(50))
		new /obj/item/storage/backpack/industrial(src)
	else
		new /obj/item/storage/backpack/satchel/eng(src)
	new /obj/item/device/radio/headset/headset_cargo(src)
	new /obj/item/clothing/under/rank/miner(src)
	new /obj/item/clothing/gloves/thick(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/device/analyzer(src)
	new /obj/item/storage/ore(src)
	new /obj/item/device/flashlight/lantern(src)
	new /obj/item/shovel(src)
	new /obj/item/pickaxe(src)
	new /obj/item/clothing/glasses/hud/standard/meson(src)

/*****************************Pickaxe********************************/

/obj/item/pickaxe
	name = "pickaxe"
	desc = "Pure classics."
	icon = 'icons/obj/tools.dmi'
	obj_flags = OBJ_FLAG_CONDUCTIBLE
	slot_flags = SLOT_BELT
	force = 14.5
	throwforce = 10.0
	mod_weight = 1.35
	mod_reach = 1.25
	mod_handy = 0.9
	icon_state = "pickaxe"
	item_state = "pickaxe"
	w_class = ITEM_SIZE_HUGE
	matter = list(MATERIAL_STEEL = 3750)
	origin_tech = list(TECH_MATERIAL = 1, TECH_ENGINEERING = 1)
	attack_verb = list("hit", "pierced", "sliced", "attacked")
	sharp = 1

	var/power = 10 //Power to an item var so R&D can make improved picks
	var/drilling = FALSE
	var/excavation_amount = 0
	var/drill_sound = 'sound/effects/fighting/Genhit.ogg'
	var/drill_verb = "picking"

/obj/item/pickaxe/drill
	name = "mining drill" //Can dig sand as well!
	icon_state = "handdrill"
	item_state = "jackhammer"
	desc = "The most basic of mining drills, for short excavations and small mineral extractions."
	power = 100 //It will remove the rock in one go, but SLOWLY
	drill_verb = "drilling"
	power = 100
	var/digspeed = 40 //Delay to an item var so R&D can make improved drills

/obj/item/pickaxe/silver
	name = "silver pickaxe"
	icon_state = "spickaxe"
	item_state = "spickaxe"
	power = 30
	origin_tech = list(TECH_MATERIAL = 3)
	desc = "This makes no metallurgic sense."

/obj/item/pickaxe/drill/adv
	name = "advanced mining drill"
	icon_state = "advdrill"
	item_state = "jackhammer"
	force = 15.5
	digspeed = 30
	origin_tech = list(TECH_MATERIAL = 2, TECH_POWER = 3, TECH_ENGINEERING = 2)
	desc = "Yours is the drill that will pierce through the rock walls."
	drill_verb = "drilling"

/obj/item/pickaxe/jackhammer
	name = "sonic jackhammer"
	icon_state = "jackhammer"
	item_state = "jackhammer"
	force = 17.5
	mod_weight = 1.5
	mod_reach = 1.35
	mod_handy = 0.9
	power = 50 //faster than drill, but cannot dig
	origin_tech = list(TECH_MATERIAL = 3, TECH_POWER = 2, TECH_ENGINEERING = 2)
	desc = "Cracks rocks with sonic blasts, perfect for killing cave lizards."
	drill_verb = "hammering"

/obj/item/pickaxe/gold
	name = "golden pickaxe"
	icon_state = "gpickaxe"
	item_state = "gpickaxe"
	power = 50
	origin_tech = list(TECH_MATERIAL = 4)
	desc = "This makes no metallurgic sense."

/obj/item/pickaxe/diamond
	name = "diamond pickaxe"
	icon_state = "dpickaxe"
	item_state = "dpickaxe"
	force = 19.0
	power = 80
	origin_tech = list(TECH_MATERIAL = 6, TECH_ENGINEERING = 4)
	desc = "A pickaxe with a diamond pick head."

/obj/item/pickaxe/drill/diamonddrill //When people ask about the badass leader of the mining tools, they are talking about ME!
	name = "diamond mining drill"
	icon_state = "diamonddrill"
	item_state = "jackhammer"
	force = 19.0
	digspeed = 5 //Digs through walls, girders, and can dig up sand
	origin_tech = list(TECH_MATERIAL = 6, TECH_POWER = 4, TECH_ENGINEERING = 5)
	desc = "Yours is the drill that will pierce the heavens!"
	drill_verb = "drilling"

/obj/item/pickaxe/drill/borgdrill
	name = "cyborg mining drill"
	icon_state = "pickaxe"
	item_state = "jackhammer"
	digspeed = 10
	desc = ""
	drill_verb = "drilling"

/obj/item/pickaxe/sledgehammer
	name = "sledgehammer"
	desc = "A mining hammer made of reinforced metal. You feel like smashing your boss in the face with this."
	icon_state = "sledgehammer"
	item_state = "sledgehammer0"
	slot_flags = null
	force = 15.0
	throwforce = 15.0
	attack_verb = list("smashed", "beaten", "slammed", "smacked", "struck")
	sharp = FALSE
	mod_weight = 1.5
	mod_reach = 1.0
	mod_handy = 0.4
	drill_verb = "hammering"
	power = 50
	var/wielded = 0

/obj/item/pickaxe/sledgehammer/update_twohanding()
	var/mob/living/M = loc
	if(istype(M) && M.can_wield_item(src) && is_held_twohanded(M))
		wielded = TRUE
		force = 40.0 // Higher than fireaxe's (30), but this thing is not sharp so it's probably fine
		mod_handy = 1.2
		mod_weight = 2.0
		mod_reach = 1.5
	else
		wielded = FALSE
		force = 17.5
		mod_weight = 1.5
		mod_reach = 1.0
		mod_handy = 0.4
	update_icon()
	..()

/obj/item/pickaxe/sledgehammer/update_icon()
	var/new_state = "[icon_state][wielded]"
	item_state_slots[slot_l_hand_str] = new_state
	item_state_slots[slot_r_hand_str] = new_state

/*****************************Shovel********************************/

/obj/item/shovel
	name = "shovel"
	desc = "A large tool for digging and moving dirt."
	icon = 'icons/obj/tools.dmi'
	icon_state = "shovel"
	obj_flags = OBJ_FLAG_CONDUCTIBLE
	slot_flags = SLOT_BELT
	force = 12.5
	throwforce = 8.5
	mod_weight = 1.25
	mod_reach = 1.5
	mod_handy = 0.9
	item_state = "shovel"
	w_class = ITEM_SIZE_HUGE
	origin_tech = list(TECH_MATERIAL = 1, TECH_ENGINEERING = 1)
	matter = list(MATERIAL_STEEL = 50)
	attack_verb = list("bashed", "bludgeoned", "thrashed", "whacked")
	sharp = 0
	edge = 1

/obj/item/shovel/spade
	name = "spade"
	desc = "A small tool for digging and moving dirt."
	icon_state = "spade"
	item_state = "spade"
	force = 7.5
	throwforce = 7.0
	mod_weight = 0.7
	mod_reach = 0.7
	mod_handy = 0.9
	w_class = ITEM_SIZE_SMALL

/**********************Flags**************************/

/obj/item/stack/flag
	name = "flags"
	desc = "Some colourful flags."
	singular_name = "flag"
	amount = 10
	max_amount = 10
	icon = 'icons/obj/mining.dmi'

	var/upright = 0
	var/fringe = null

/obj/item/stack/flag/red
	name = "red flags"
	singular_name = "red flag"
	icon_state = "redflag"
	fringe = "redflag_fringe"
	light_color = COLOR_RED

/obj/item/stack/flag/yellow
	name = "yellow flags"
	singular_name = "yellow flag"
	icon_state = "yellowflag"
	fringe = "yellowflag_fringe"
	light_color = COLOR_YELLOW

/obj/item/stack/flag/green
	name = "green flags"
	singular_name = "green flag"
	icon_state = "greenflag"
	fringe = "greenflag_fringe"
	light_color = COLOR_LIME

/obj/item/stack/flag/solgov
	name = "sol gov flags"
	singular_name = "sol gov flag"
	icon_state = "solgovflag"
	fringe = "solgovflag_fringe"
	desc = "A portable flag with the Sol Government symbol on it. I claim this land for Sol!"
	light_color = COLOR_BLUE

/obj/item/stack/flag/attackby(obj/item/W, mob/user)
	if(upright)
		attack_hand(user)
		return
	return ..()

/obj/item/stack/flag/attack_hand(mob/user)
	if(upright)
		knock_down()
		user.visible_message("\The [user] knocks down \the [singular_name].")
		return
	return ..()

/obj/item/stack/flag/attack_self(mob/user)
	var/turf/T = get_turf(src)

	if(istype(T, /turf/space) || istype(T, /turf/simulated/open))
		to_chat(user, SPAN_WARNING("There's no solid surface to plant the flag on."))
		return

	for(var/obj/item/stack/flag/F in T)
		if(F.upright)
			to_chat(user, SPAN_WARNING("\The [F] is already planted here."))
			return

	if(use(1)) // Don't skip use() checks even if you only need one! Stacks with the amount of 0 are possible, e.g. on synthetics!
		var/obj/item/stack/flag/newflag = new src.type(T, 1)
		newflag.set_up()
		if(istype(T, /turf/simulated/floor/asteroid))
			user.visible_message("\The [user] plants \the [newflag.singular_name] firmly in the ground.")
		else
			user.visible_message("\The [user] attaches \the [newflag.singular_name] firmly to the ground.")

/obj/item/stack/flag/proc/set_up()
	pixel_x = 0
	pixel_y = 0
	upright = 1
	anchored = 1
	icon_state = "[initial(icon_state)]_open"
	if(fringe)
		set_light(0.2, 0.1, 1) // Very dim so the rest of the flag is barely visible - if the turf is completely dark, you can't see anything on it, no matter what
		var/image/addon = image(icon = src.icon, icon_state = fringe) // Bright fringe
		addon.layer = ABOVE_LIGHTING_LAYER
		addon.plane = EFFECTS_ABOVE_LIGHTING_PLANE
		overlays += addon

/obj/item/stack/flag/proc/knock_down()
	pixel_x = rand(-randpixel, randpixel)
	pixel_y = rand(-randpixel, randpixel)
	upright = 0
	anchored = 0
	icon_state = initial(icon_state)
	overlays.Cut()
	set_light(0)

/**********************Mining car (Crate like thing, not the rail car)**************************/

/obj/structure/closet/crate/miningcar
	desc = "A mining car. This one doesn't work on rails, but has to be dragged."
	name = "Mining car (not for rails)"
	icon = 'icons/obj/storage.dmi'
	icon_state = "miningcar"
	density = 1
	icon_opened = "miningcaropen"
	icon_closed = "miningcar"
	pull_slowdown = PULL_SLOWDOWN_LIGHT

/**********************Pinpointer**********************/

/obj/item/ore_radar
	name = "scanner pad"
	desc = "An antiquated device that can detect ore in a wide radius around the user."
	icon = 'icons/obj/mining.dmi'
	icon_state = "pinoff"
	obj_flags = OBJ_FLAG_CONDUCTIBLE
	slot_flags = SLOT_BELT
	w_class = 2.0
	item_state = "electronic"
	throw_range = 20
	matter = list(MATERIAL_STEEL = 500)
	var/turf/simulated/mineral/random/sonar = null
	var/active = 0


/obj/item/ore_radar/attack_self(mob/user)
	if(!active)
		active = 1
		to_chat(usr, SPAN_NOTICE("You activate the pinpointer."))
		set_next_think(world.time)
	else
		active = 0
		icon_state = "pinoff"
		to_chat(usr, SPAN_NOTICE("You deactivate the pinpointer."))
		set_next_think(0)

/obj/item/ore_radar/think()
	if(!active)
		return

	workdisk()
	set_next_think(world.time + 2 SECONDS)

/obj/item/ore_radar/proc/workdisk()
	if(!src.loc)
		active = 0

	if(!active)
		return

	var/closest = 15

	for(var/turf/simulated/mineral/random/R in orange(14,loc))
		if(!R.mineral)
			continue
		var/dist = get_dist(loc, R)
		if(dist < closest)
			closest = dist
			sonar = R

	if(!sonar)
		icon_state = "pinonnull"
		return
	set_dir(get_dir(loc,sonar))
	switch(get_dist(loc,sonar))
		if(0)
			icon_state = "pinondirect"
		if(1 to 8)
			icon_state = "pinonclose"
		if(9 to 16)
			icon_state = "pinonmedium"
		if(16 to INFINITY)
			icon_state = "pinonfar"

/**********************Lazarus Injector**********************/

/obj/item/lazarus_injector
	name = "lazarus injector"
	desc = "An injector with a cocktail of nanomachines and chemicals, this device can seemingly raise animals from the dead. If no effect in 3 days please call customer support."
	icon = 'icons/obj/device.dmi'
	icon_state = "animal_tagger1"
	item_state = "hypo"
	throwforce = 0
	w_class = 2
	throw_range = 5
	var/loaded = 1
	var/malfunctioning = FALSE
	var/emagged = FALSE
	origin_tech = list(TECH_BIO = 7, TECH_MATERIAL = 4)

/obj/item/lazarus_injector/afterattack(atom/target, mob/user, proximity_flag)
	if(!loaded)
		return
	if(isliving(target) && proximity_flag)
		if(isanimal(target))
			var/mob/living/simple_animal/M = target
			if(M.is_ooc_dead())
				M.faction = "neutral"
				if(emagged)	//if emagged, will set anything revived to the syndicate. Convert station pets to the traitor side!
					M.faction = "syndicate"
				if(malfunctioning) //when EMP'd, will set the mob faction to its initial faction, so any taming will be reverted.
					M.faction = initial(M.faction)
				M.revive()
				M.icon_state = M.icon_living
				M.desc = initial(M.desc)
				loaded = 0
				icon_state = "animal_tagger0"
				user.visible_message(SPAN_NOTICE("\The [user] revives \the [M] by injecting it with \the [src]."))
				feedback_add_details("lazarus_injector", "[M.type]")
				playsound(src, 'sound/effects/refill.ogg', 50, 1)
				return
			else
				to_chat(user, "<span class='info'>[src] is only effective on the dead.</span>")
				return
		else
			to_chat(user, "<span class='info'>[src] is only effective on lesser beings.</span>")
			return

/obj/item/lazarus_injector/attackby(obj/item/I, mob/living/user)
	if(istype(I, /obj/item/card/emag) && !emagged)
		var/obj/item/card/emag/emag_card = I
		if(!emag_card.uses)
			return
		emagged = TRUE
		emag_card.uses -= 1
		to_chat(user, SPAN_WARNING("You overload \the [src]'s injection matrix."))
		return

	return ..()

/obj/item/lazarus_injector/emp_act()
	if(!malfunctioning)
		malfunctioning = TRUE

/obj/item/lazarus_injector/_examine_text(mob/user)
	. = ..()
	if(!loaded)
		. += "\n<span class='info'>[src] is empty.</span>"
	if(malfunctioning || emagged)
		. += "\n<span class='info'>The display on [src] seems to be flickering.</span>"

/**********************Point Transfer Card**********************/

/obj/item/card/mining_point_card
	name = "mining points card"
	desc = "A small card preloaded with mining points. Swipe your ID card over it to transfer the points, then discard."
	icon_state = "data"
	var/points = 500

/obj/item/card/mining_point_card/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/card/id))
		if(points)
			var/obj/item/card/id/C = I
			C.mining_points += points
			to_chat(user, "<span class='info'>You transfer [points] points to [C].</span>")
			points = 0
		else
			to_chat(user, "<span class='info'>There's no points left on [src].</span>")
	..()

/obj/item/card/mining_point_card/_examine_text(mob/user)
	. = ..()
	. += "\nThere's [points] point\s on the card."

/**********************Resonator**********************/

/obj/item/resonator
	name = "resonator"
	icon = 'icons/obj/mining.dmi'
	icon_state = "resonator"
	item_state = "resonator"
	desc = "A handheld device that creates small fields of energy that resonate until they detonate, crushing rock. It can also be activated without a target to create a field at the user's location, to act as a delayed time trap. It's more effective in a vacuum."
	w_class = ITEM_SIZE_HUGE
	force = 20.0
	mod_weight = 1.5
	mod_reach = 1.25
	mod_handy = 0.9
	throwforce = 10
	var/burst_time = 50
	var/fieldlimit = 4
	var/list/fields = list()
	var/quick_burst_mod = 0.8
	origin_tech = list(TECH_MAGNET = 3, TECH_ENGINEERING = 3)

/obj/item/resonator/upgraded
	name = "upgraded resonator"
	desc = "An upgraded version of the resonator that can produce more fields at once."
	icon_state = "resonatoru"
	item_state = "resonatoru"
	origin_tech = list(TECH_MAGNET = 3, TECH_MATERIAL = 4, TECH_POWER = 2, TECH_ENGINEERING = 3)
	fieldlimit = 8
	quick_burst_mod = 1
	burst_time = 30

/obj/item/resonator/proc/CreateResonance(target, creator)
	var/turf/T = get_turf(target)
	var/obj/effect/resonance/R = locate(/obj/effect/resonance) in T
	if(R)
		R.resonance_damage *= quick_burst_mod
		R.burst(T)
		return
	if(fields.len < fieldlimit)
		playsound(src,'sound/effects/weapons/energy/resonator_fire.ogg',50,1)
		var/obj/effect/resonance/RE = new /obj/effect/resonance(T, creator, burst_time, src)
		fields += RE

/obj/item/resonator/attack_self(mob/user)
	if(burst_time == 50)
		burst_time = 30
		to_chat(user, "<span class='info'>You set the resonator's fields to detonate after 3 seconds.</span>")
	else
		burst_time = 50
		to_chat(user, "<span class='info'>You set the resonator's fields to detonate after 5 seconds.</span>")

/obj/item/resonator/afterattack(atom/target, mob/user, proximity_flag)
	..()
	if(user.Adjacent(target))
		if(isturf(target))
			CreateResonance(target, user)

/obj/effect/resonance
	name = "resonance field"
	desc = "A resonating field that significantly damages anything inside of it when the field eventually ruptures."
	icon = 'icons/effects/effects.dmi'
	icon_state = "shield2"
	layer = 5
	anchored = TRUE
	mouse_opacity = 0
	var/resonance_damage = 10
	var/creator
	var/obj/item/resonator/res

/obj/effect/resonance/New(loc, set_creator, timetoburst, set_resonator)
	..()
	creator = set_creator
	res = set_resonator
	var/turf/proj_turf = get_turf(src)
	if(!istype(proj_turf))
		return
	var/datum/gas_mixture/environment = proj_turf.return_air()
	var/pressure = environment.return_pressure()
	if(pressure < 50)
		name = "strong resonance field"
		resonance_damage = 30

	addtimer(CALLBACK(src, .proc/burst, loc), timetoburst)

/obj/effect/resonance/Destroy()
	if(res)
		res.fields -= src
	return ..()

/obj/effect/resonance/proc/burst(turf/T)
	playsound(src,'sound/weapons/resonator_blast.ogg',50,1)
	if(istype(T, /turf/simulated/mineral))
		var/turf/simulated/mineral/M = T
		M.GetDrilled(1)
	for(var/mob/living/L in T)
		to_chat(L, "<span class='danger'>The [src.name] ruptured with you in it!</span>")
		L.apply_damage(resonance_damage, BRUTE)
	qdel(src)


/******************************Ore Magnet*******************************/
/obj/item/oremagnet
	name = "ore magnet"
	icon = 'icons/obj/mining.dmi'
	icon_state = "magneto"
	item_state = "jaunter"
	desc = "A handheld device that creates a well of negative force that attracts minerals of a very specific type, size, and state to its user."
	w_class = 3
	force = 10
	throwforce = 5
	origin_tech = list(TECH_MAGNET = 4, TECH_ENGINEERING = 3)
	var/on = 0

/obj/item/oremagnet/attack_self(mob/user)
	if (!ishuman(user))
		return
	toggle_on(user)

/obj/item/oremagnet/think()
	if(!on)
		return

	for(var/obj/item/ore/O in oview(7, loc))
		if(prob(80))
			step_to(O, src.loc, 0)

		if (TICK_CHECK)
			break

	set_next_think(world.time + 1 SECOND)

/obj/item/oremagnet/proc/toggle_on(mob/user)
	if (!on)
		set_next_think(world.time)
		on = 1
		to_chat(user, "You turn it on.")
	else
		set_next_think(0)
		on = 0
		to_chat(user, "You turn it off.")

/******************************Ore Summoner*******************************/

/obj/item/oreportal
	name = "ore summoner"
	icon = 'icons/obj/mining.dmi'
	icon_state = "supermagneto"
	item_state = "jaunter"
	desc = "A handheld device that creates a well of warp energy that teleports minerals of a very specific type, size, and state to its user."
	w_class = 3
	force = 15
	throwforce = 5
	origin_tech = list(TECH_BLUESPACE = 4, TECH_ENGINEERING = 3)

/obj/item/oreportal/attack_self(mob/user)
	to_chat(user, "<span class='info'>You pulse the ore summoner.</span>")
	var/limit = 10
	for(var/obj/item/ore/O in orange(7,user))
		if(limit <= 0)
			break
		new /obj/effect/sparks(O.loc)
		do_teleport(O, user, 0)
		limit -= 1
		CHECK_TICK

/******************************Sculpting*******************************/
/obj/item/autochisel
	name = "auto-chisel"
	icon = 'icons/obj/mining.dmi'
	icon_state = "auto-chisel"
	item_state = "jackhammer"
	origin_tech = list(TECH_MATERIAL = 3, TECH_POWER = 2, TECH_ENGINEERING = 2)
	desc = "With an integrated AI chip and hair-trigger precision, this baby makes sculpting almost automatic!"

/obj/structure/sculpting_block
	name = "sculpting block"
	desc = "A finely chiselled sculpting block, it is ready to be your canvas."
	icon = 'icons/obj/mining.dmi'
	icon_state = "sculpting_block"
	density = 1
	opacity = 1
	anchored = 0
	var/sculpted = 0
	var/mob/living/T
	var/times_carved = 0
	var/last_struck = 0

/obj/structure/sculpting_block/verb/rotate()
	set name = "Rotate"
	set category = "Object"
	set src in oview(1)

	if (src.anchored || usr:stat)
		to_chat(usr, "It is fastened to the floor!")
		return 0
	src.set_dir(turn(src.dir, 90))
	return 1

/obj/structure/sculpting_block/attackby(obj/item/C as obj, mob/user as mob)

	if (isWrench(C))
		playsound(src.loc, 'sound/items/Ratchet.ogg', 100, 1)
		to_chat(user, "<span class='notice'>You [anchored ? "un" : ""]anchor the [name].</span>")
		anchored = !anchored

	if (istype(C, /obj/item/autochisel))
		if(!sculpted)
			if(last_struck)
				return

			if(!T)
				var/list/choices = list()
				for(var/mob/living/M in view(7,user))
					choices += M
				T = input(user,"Who do you wish to sculpt?") as null|anything in choices
				user.visible_message("<span class='notice'>[user] begins sculpting.</span>",
					"<span class='notice'>You begin sculpting.</span>")

			var/sculpting_coefficient = get_dist(user,T)
			if(sculpting_coefficient <= 0)
				sculpting_coefficient = 1

			if(sculpting_coefficient >= 7)
				to_chat(user, "<span class='warning'>You hardly remember what [T] really looks like! Bah!</span>")
				T = null

			user.visible_message("<span class='notice'>[user] carves away at the sculpting block!</span>",
				"<span class='notice'>You continue sculpting.</span>")

			playsound(user, GET_SFX(SFX_USE_CHISEL), 30, 1)
			spawn(3)
				playsound(user, GET_SFX(SFX_USE_CHISEL), 30, 1)
				spawn(3)
					playsound(user, GET_SFX(SFX_USE_CHISEL), 30, 1)

			last_struck = 1
			if(do_after(user,(20)))
				last_struck = 0
				if(times_carved <= 9)
					times_carved += 1
					if(times_carved < 1)
						to_chat(user, "<span class='notice'>You review your work and see there is more to do.</span>")
					return
				else
					sculpted = 1
					user.visible_message("<span class='notice'>[user] finishes sculpting their magnum opus!</span>",
						"<span class='notice'>You finish sculpting a masterpiece.</span>")
					src.appearance = T
					appearance_flags = DEFAULT_APPEARANCE_FLAGS | KEEP_TOGETHER
					src.color = list(
					    0.35, 0.3, 0.25,
					    0.35, 0.3, 0.25,
					    0.35, 0.3, 0.25
					)
					src.pixel_y += 8
					var/image/pedestal_underlay = image('icons/obj/mining.dmi', icon_state = "pedestal")
					pedestal_underlay.appearance_flags = DEFAULT_APPEARANCE_FLAGS | RESET_COLOR
					pedestal_underlay.pixel_y -= 8
					src.underlays += pedestal_underlay
					var/title = sanitize(input(usr, "If you would like to name your art, do so here.", "Christen Your Sculpture", "") as text|null)
					if(title)
						name = title
					else
						name = "*[T.name]*"
					var/legend = sanitize(input(usr, "If you would like to describe your art, do so here.", "Story Your Sculpture", "") as message|null)
					if(legend)
						desc = legend
					else
						desc = "This is a sculpture of [T.name]. All craftsmanship is of the highest quality. It is decorated with rock and more rock. It is covered with rock. On the item is an image of a rock. The rock is [T.name]."
			else
				last_struck = 0
		return
