//Refer to life.dm for caller

/mob/living/carbon/human/proc/handle_disabilities()
	if(disabilities & NERVOUS)
		if(prob(10))
			stuttering = max(10, stuttering)
			return

	if(stat != DEAD)
		var/roll = rand(0, 200)
		switch(roll)
			if(0 to 3)
				if(getBrainLoss() >= 5)
					custom_pain("Your head feels numb and painful.")
			if(4 to 6)
				if(getBrainLoss() >= 15 && eye_blurry <= 0)
					to_chat(src, SPAN_DANGER("不知为何，视线开始模糊。"))
					AdjustEyeBlur(10)
			if(7 to 9)
				if(getBrainLoss() >= 35 && (hand && get_held_item()))
					to_chat(src, SPAN_DANGER("你的手不听使唤，松开了手中的东西。"))
					drop_held_item()
			if(10 to 12)
				if(getBrainLoss() >= 50 && body_position == STANDING_UP)
					to_chat(src, SPAN_DANGER("你的双腿不听使唤，摔倒在地。"))
					resting = 1
