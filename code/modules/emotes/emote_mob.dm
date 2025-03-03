/mob/proc/can_emote(emote_type)
	return (stat == CONSCIOUS)

/mob/living/can_emote(emote_type)
	return (..() && !(silent && emote_type == AUDIBLE_MESSAGE))

/mob/proc/emote(act, m_type, message)
	// s-s-snowflake
	if(src.is_ic_dead() && act != "deathgasp")
		return
	if(usr == src) //client-called emote
		if (client && (client.prefs.muted & MUTE_IC))
			to_chat(src, "<span class='warning'>You cannot send IC messages (muted).</span>")
			return
		if(!can_emote(m_type))
			to_chat(src, "<span class='warning'>You cannot currently [m_type == AUDIBLE_MESSAGE ? "audibly" : "visually"] emote!</span>")
			return

		if(act == "me")
			return custom_emote(m_type, message)

		if(act == "custom")
			if(!message)
				message = sanitize(input("Enter an emote to display.") as text|null)
			if(!message)
				return
			if(alert(src, "Is this an audible emote?", "Emote", "Yes", "No") == "No")
				m_type = VISIBLE_MESSAGE
			else
				m_type = AUDIBLE_MESSAGE
			return custom_emote(m_type, message)

	var/splitpoint = findtext_char(act, " ")
	if(splitpoint > 0)
		var/tempstr = act
		act = copytext_char(tempstr,1,splitpoint)
		message = copytext_char(tempstr,splitpoint+1,0)

	act = sanitize_cyrillic_string(act)

	if(act == "help")
		to_chat(src,"<b>Usable emotes:</b> [english_list(usable_emotes)]")
		return

	var/decl/emote/use_emote = usable_emotes[act]
	if(!use_emote)
		to_chat(src, "<span class='warning'>Unknown emote '[act]'. Type <b>say *help</b> for a list of usable emotes.</span>")
		return

	if((m_type && m_type != use_emote.message_type) || (use_emote.conscious && stat != CONSCIOUS))
		to_chat(src, "<span class='warning'>You cannot currently [use_emote.message_type == AUDIBLE_MESSAGE ? "audibly" : "visually"] emote!</span>")
		return

	if(use_emote.message_type == AUDIBLE_MESSAGE && is_muzzled())
		audible_message("<b>\The [src]</b> makes a muffled sound.")
		return
	else
		use_emote.do_emote(src, message)

	for (var/obj/item/implant/I in src)
		if (I.implanted)
			I.trigger(act, src)

/mob/proc/format_emote(source = null, message = null)
	var/pretext
	var/subtext
	var/nametext
	var/end_char
	var/start_char
	var/name_anchor

	if(!message || !source)
		return

	// Store the player's name in a nice bold, naturalement
	nametext = "<B>[source]</B>"

	name_anchor = findtext(message, "^")
	if(name_anchor > 0) // User supplied emote with a carat
		pretext = copytext(message, 1, name_anchor)
		subtext = copytext(message, name_anchor + 1, length(message) + 1)
	else
		// No carat. Just the emote as usual.
		subtext = message

	// Oh shit, we got this far! Let's see... did the user attempt to use more than one carat?
	if(findtext(subtext, "^"))
		// abort abort!
		return 0

	// Auto-capitalize our pretext if there is any.
	if(pretext)
		pretext = capitalize(pretext)
		// Add a space at the end if we didn't already supply one.
		end_char = copytext(pretext, length(pretext), length(pretext) + 1)
		if(end_char != " ")
			pretext += " "

	// Grab the last character of the emote message.
	end_char = copytext(subtext, length(subtext), length(subtext) + 1)
	if(end_char != "." && end_char != "?" && end_char != "!" && end_char != "\"")
		// No punctuation supplied. Tack a period on the end.
		subtext += "."

	// Add a space to the subtext, unless it begins with an apostrophe or comma... or a space.
	if(subtext != ".")
		start_char = copytext(subtext, 1, 2)
		if(start_char != "," && start_char != " " && start_char != "&") // Apostrophes are parsed as "&#039;", so uhh, yeah.
			subtext = " " + subtext

	return pretext + nametext + subtext

/mob/proc/custom_emote(m_type = VISIBLE_MESSAGE, message = null)

	if((usr && stat) || (!use_me && usr == src))
		to_chat(src, "You are unable to emote.")
		return

	var/input
	if(!message)
		input = sanitize(input(src,"Choose an emote to display.") as text|null)
	else
		input = message

	if(input)
		message = format_emote(src, message)
	else
		return

	if (message)
		log_emote("[key_name(src)]: [message]")
		log_message(input, INDIVIDUAL_SAY_LOG, "\[EMOTE\]")

	//do not show NPC animal emotes to ghosts, it turns into hellscape
	var/check_ghosts = client ? /datum/client_preference/ghost_sight : null
	if(m_type == VISIBLE_MESSAGE)
		visible_message(message, checkghosts = check_ghosts)
	else
		audible_message(message, checkghosts = check_ghosts)

// Specific mob type exceptions below.
/mob/living/silicon/ai/emote(act, type, message)
	var/obj/machinery/hologram/holopad/T = src.holo
	if(T && T.masters[src]) //Is the AI using a holopad?
		src.holopad_emote(message)
	else //Emote normally, then.
		..()

/mob/living/captive_brain/emote(message)
	return

/mob/observer/ghost/emote(act, type, message)
	if(message && act == "me")
		communicate(/decl/communication_channel/dsay, client, message, /decl/dsay_communication/emote)
