/obj/structure/largecrate
	name = "large crate"
	desc = "A hefty wooden crate."
	icon = 'icons/obj/storage.dmi'
	icon_state = "densecrate"
	density = 1

/obj/structure/largecrate/initialize()
	..()
	for(var/obj/I in src.loc)
		if(I.density || I.anchored || I == src || !I.simulated)
			continue
		I.forceMove(src)

/obj/structure/largecrate/attack_hand(mob/user as mob)
	to_chat(user, "<span class='notice'>You need a crowbar to pry this open!</span>")
	return

/obj/structure/largecrate/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/crowbar))
		new /obj/item/stack/material/wood(src)
		var/turf/T = get_turf(src)
		for(var/atom/movable/AM in contents)
			if(AM.simulated) AM.forceMove(T)
		user.visible_message("<span class='notice'>[user] pries \the [src] open.</span>", \
							 "<span class='notice'>You pry open \the [src].</span>", \
							 "<span class='notice'>You hear splitting wood.</span>")
		qdel(src)
	else
		return attack_hand(user)

/obj/structure/largecrate/mule
	name = "MULE crate"

/obj/structure/largecrate/hoverpod
	name = "\improper Hoverpod assembly crate"
	desc = "It comes in a box for the fabricator's sake. Where does the wood come from? ... And why is it lighter?"
	icon_state = "mulecrate"

/obj/structure/largecrate/hoverpod/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/crowbar))
		var/obj/item/mecha_parts/mecha_equipment/ME
		var/obj/mecha/working/hoverpod/H = new (loc)

		ME = new /obj/item/mecha_parts/mecha_equipment/tool/hydraulic_clamp
		ME.attach(H)
		ME = new /obj/item/mecha_parts/mecha_equipment/tool/passenger
		ME.attach(H)
	..()

/obj/structure/largecrate/animal
	icon_state = "mulecrate"
	var/held_count = 1
	var/held_type

/obj/structure/largecrate/animal/New()
	..()
	for(var/i = 1;i<=held_count;i++)
		new held_type(src)

/obj/structure/largecrate/animal/mulebot
	name = "Mulebot crate"
	held_type = /mob/living/bot/mulebot

/obj/structure/largecrate/animal/corgi
	name = "corgi carrier"
	held_type = /mob/living/simple_animal/corgi

/obj/structure/largecrate/animal/cow
	name = "cow crate"
	held_type = /mob/living/simple_animal/cow

/obj/structure/largecrate/animal/goat
	name = "goat crate"
	held_type = /mob/living/simple_animal/hostile/retaliate/goat

/obj/structure/largecrate/animal/cat
	name = "cat carrier"
	held_type = /mob/living/simple_animal/cat

/obj/structure/largecrate/animal/cat/bones
	held_type = /mob/living/simple_animal/cat/fluff/bones

/obj/structure/largecrate/animal/chick
	name = "chicken crate"
	held_count = 5
	held_type = /mob/living/simple_animal/chick

//---------- EROS BEGIN - SPECIAL LARGE CRATES

/obj/structure/largecrate/anomaly
	name = "anomaly crate"
	desc = "A specially designed crate filled with argon gas and lined with Etherium-482 \"Telekill\" alloy to suppress and contain anomalous effects."
	icon_state = "anomalycrate"

/obj/structure/largecrate/anomaly/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/crowbar))
		new /obj/item/stack/material/steel(src)
		new /obj/machinery/artifact(src)
		var/turf/T = get_turf(src)
		for(var/atom/movable/AM in contents)
			if(AM.simulated) AM.forceMove(T)
		user.visible_message("<span class='notice'>[user] pries \the [src] apart. The inert gas escapes, making the alloy lining evaporate.</span>", \
							 "<span class='notice'>You pry \the [src] apart. The inert gas escapes, making the alloy lining evaporate.</span>", \
							 "<span class='notice'>You hear groaning metal and a momentary rush of wind.</span>")
		qdel(src)
	else
		return attack_hand(user)
