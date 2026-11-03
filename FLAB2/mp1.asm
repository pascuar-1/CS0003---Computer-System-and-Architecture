; The Mystic Zodiac Oracle
; NASM x86 32-bit Linux console program using int 0x80 system calls.

section .data
	welcomeBanner db 10, "========================================", 10
				  db "       THE MYSTIC ZODIAC ORACLE", 10
				  db "========================================", 10, 0
	welcomeArt db "              .-.", 10
			   db "           .-(   )-.", 10
			   db "          (_  .-.  _)", 10
			   db "            /     ", 92, 10
			   db "           | (*) (*) |", 10
			   db "             ", 92, " ^  /", 10
			   db "              |||||", 10, 0
	discoverText db 10, "DISCOVER YOUR DESTINY", 10, 10, 0

	namePrompt db "Enter your name: ", 0
	monthPrompt db "Enter birth month (1-12): ", 0
	dayPrompt db "Enter birth day (1-31): ", 0
	invalidMonthMsg db "Invalid month.", 10, 0
	invalidDateMsg db "Invalid date.", 10, 0

	zodiacBanner db 10, "=======================================", 10
				 db "          YOUR ZODIAC SIGN", 10
				 db "=======================================", 10, 0
	zodiacNameLabel db "Zodiac Sign: ", 0
	elementLabel db "Element: ", 0
	symbolLabel db "Symbol: ", 0
	personalityLabel db "Personality: ", 0
	commaSpace db ", ", 0
	lineFeed db 10, 0

	menuBanner db 10, "=======================================", 10
			   db "          HOROSCOPE MENU", 10
			   db "=======================================", 10
			   db "[1] Love and Relationships", 10
			   db "[2] Career and Studies", 10
			   db "[3] Health and Wellness", 10
			   db "[4] Lucky Number and Color", 10
			   db "[5] View Zodiac Information", 10
			   db "[6] Exit", 10
			   db "Enter your choice: ", 0
	invalidChoiceMsg db "Invalid selection. Please try again.", 10, 0
	returnPrompt db 10, "Return to menu? (Y/N): ", 0
	invalidReturnMsg db "Please enter Y or N.", 10, 0

	loveHeading db 10, "LOVE AND RELATIONSHIPS", 10, 0
	careerHeading db 10, "CAREER AND STUDIES", 10, 0
	healthHeading db 10, "HEALTH AND WELLNESS", 10, 0
	luckyHeading db 10, "LUCKY NUMBER AND COLOR", 10, 0
	luckyNumberLabel db "Lucky Number: ", 0
	luckyColorLabel db "Lucky Color: ", 0

	exitMessage db 10, "=======================================", 10
				db "Thank you for using", 10
				db "THE MYSTIC ZODIAC ORACLE", 10
				db "May the stars guide your journey!", 10
				db "=======================================", 10, 0
	exitArt db "                 *", 10
			 db "                /|\", 10
			 db "           *---(   )---*", 10
			 db "                \|/", 10
			 db "                 *", 10, 0

	signCapricorn db "Capricorn", 0
	signAquarius db "Aquarius", 0
	signPisces db "Pisces", 0
	signAries db "Aries", 0
	signTaurus db "Taurus", 0
	signGemini db "Gemini", 0
	signCancer db "Cancer", 0
	signLeo db "Leo", 0
	signVirgo db "Virgo", 0
	signLibra db "Libra", 0
	signScorpio db "Scorpio", 0
	signSagittarius db "Sagittarius", 0

	elementEarth db "Earth", 0
	elementAir db "Air", 0
	elementWater db "Water", 0
	elementFire db "Fire", 0
	symbolGoat db "Sea-Goat", 0
	symbolWaterBearer db "Water-Bearer", 0
	symbolFish db "Fish", 0
	symbolRam db "Ram", 0
	symbolBull db "Bull", 0
	symbolTwins db "Twins", 0
	symbolCrab db "Crab", 0
	symbolLion db "Lion", 0
	symbolMaiden db "Maiden", 0
	symbolScales db "Scales", 0
	symbolScorpion db "Scorpion", 0
	symbolArcher db "Archer", 0

	personalityCapricorn db "Patient, Practical, Determined", 0
	personalityAquarius db "Inventive, Independent, Humanitarian", 0
	personalityPisces db "Imaginative, Gentle, Compassionate", 0
	personalityAries db "Bold, Energetic, Adventurous", 0
	personalityTaurus db "Reliable, Patient, Appreciative", 0
	personalityGemini db "Curious, Witty, Adaptable", 0
	personalityCancer db "Caring, Intuitive, Protective", 0
	personalityLeo db "Confident, Creative, Courageous", 0
	personalityVirgo db "Thoughtful, Precise, Helpful", 0
	personalityLibra db "Diplomatic, Charming, Fair-minded", 0
	personalityScorpio db "Focused, Resourceful, Passionate", 0
	personalitySagittarius db "Optimistic, Curious, Independent", 0

	artCapricorn db "              /\_/\\", 10
				  db "             ( o.o )", 10
				  db "              > ^ <", 10, 0
	artAquarius db "                .-.", 10
				 db "             .-(   )-.", 10
				 db "                | |", 10
				 db "             ~~~| |~~~", 10, 0
	artPisces db "             ><(((('>", 10
			   db "             <'))))><", 10, 0
	artAries db "                /\\", 10
			  db "              _(  )_", 10
			  db "             (  \/  )", 10, 0
	artTaurus db "              (__) ", 10
			   db "            _(    )_", 10
			   db "           (________)", 10, 0
	artGemini db "             (o) (o)", 10
			   db "              |   |", 10
			   db "             /|   |\\", 10, 0
	artCancer db "               .--.", 10
			   db "            .-(    )-.", 10
			   db "           (  (    )  )", 10, 0
	artLeo db "              .----.", 10
			 db "             / .--. ", 10
			 db "            | (    )", 10
			 db "             \\ '--' /", 10, 0
	artVirgo db "               /\\", 10
			   db "              /  \\___", 10
			   db "             /       /", 10
			   db "            /_______/", 10, 0
	artLibra db "             _______", 10
			   db "                |", 10
			   db "             ___|___", 10
			   db "            /_______\\", 10, 0
	artScorpio db "              .==.     _", 10
				 db "             (    )---(_>", 10
				 db "              '== '\", 10, 0
	artSagittarius db "                 /", 10
					 db "                /  /", 10
					 db "               /__/", 10
					 db "              /  /", 10, 0

	loveCapricorn db "Your steady nature makes room for a sincere connection today.", 10
					db "A thoughtful gesture can say more than a grand promise.", 10, 0
	loveAquarius db "An unexpected conversation may spark an exciting connection.", 10
				   db "Let your originality show while making space to listen.", 10, 0
	lovePisces db "A kind moment helps deepen a bond that already matters.", 10
				 db "Trust your intuition, but ask rather than assume.", 10, 0
	loveAries db "Your direct warmth makes it easier to clear the air today.", 10
				db "Offer encouragement and let affection grow at its own pace.", 10, 0
	loveTaurus db "A familiar ritual brings comfort to someone close to you.", 10
				 db "Share what you value instead of waiting to be asked.", 10, 0
	loveGemini db "A lively exchange gives a friendship a welcome new spark.", 10
				 db "Choose your words with care when a topic turns personal.", 10, 0
	loveCancer db "A quiet check-in helps someone feel truly understood.", 10
				 db "Protect your own boundaries as generously as you protect others.", 10, 0
	loveLeo db "Your confidence will attract positive attention today.", 10
			  db "Open your heart and trust meaningful conversations.", 10, 0
	loveVirgo db "A small act of care speaks clearly to someone you cherish.", 10
				db "Let the moment be imperfect and enjoy it anyway.", 10, 0
	loveLibra db "A balanced conversation restores ease in an important bond.", 10
				db "Say what you need with kindness and clear intention.", 10, 0
	loveScorpio db "Honesty can turn a guarded moment into genuine closeness.", 10
				  db "Share one feeling you usually keep beneath the surface.", 10, 0
	loveSagittarius db "A playful invitation brings fresh energy to your social world.", 10
					  db "Be candid about your plans so others can join in.", 10, 0

	careerCapricorn db "A patient, step-by-step effort moves a long project forward.", 10
					  db "Your follow-through earns quiet respect from the team.", 10, 0
	careerAquarius db "A novel approach helps untangle a stubborn work problem.", 10
					 db "Share the idea early and invite useful collaboration.", 10, 0
	careerPisces db "Your imagination reveals an answer hidden in the details.", 10
				   db "Give your best idea a simple, practical first step.", 10, 0
	careerAries db "A timely burst of initiative gets a stalled task moving.", 10
				  db "Set one clear priority before charging into the next.", 10, 0
	careerTaurus db "Consistent practice brings a noticeable improvement today.", 10
				   db "Finish one valuable task before taking on another.", 10, 0
	careerGemini db "A question you ask opens up a useful learning opportunity.", 10
				   db "Capture your notes before a new idea takes the lead.", 10, 0
	careerCancer db "Your sense of timing helps the group work more smoothly.", 10
				   db "A calm workspace will make concentration easier.", 10, 0
	careerLeo db "Your creativity will help you solve a difficult problem today.", 10
				db "Stay focused and confident.", 10, 0
	careerVirgo db "Careful preparation catches a detail others may have missed.", 10
				  db "Share your findings clearly instead of polishing them endlessly.", 10, 0
	careerLibra db "A fair compromise gets a shared assignment back on track.", 10
				  db "Put the next steps in writing while everyone is aligned.", 10, 0
	careerScorpio db "Deep concentration lets you make progress on complex work.", 10
					db "Keep a useful discovery private until it is ready to present.", 10, 0
	careerSagittarius db "A new subject catches your attention and expands your options.", 10
						db "Turn your enthusiasm into a realistic study plan.", 10, 0

	healthCapricorn db "Your energy benefits from a steady pace and regular pauses.", 10
					  db "A simple routine is more valuable than an ambitious reset.", 10, 0
	healthAquarius db "A change of scenery can refresh your focus and mood.", 10
					 db "Take a screen break and reconnect with your surroundings.", 10, 0
	healthPisces db "A peaceful few minutes helps you reset after a busy stretch.", 10
				   db "Drink some water and give yourself room to recharge.", 10, 0
	healthAries db "A short movement break helps release restless energy.", 10
				  db "Ease into activity and notice what your body is telling you.", 10, 0
	healthTaurus db "Comfort and consistency make today a good day for self-care.", 10
				   db "Choose nourishing rest over pushing through fatigue.", 10, 0
	healthGemini db "A little fresh air can settle a mind full of ideas.", 10
				   db "Try one thing at a time and give your attention a breather.", 10, 0
	healthCancer db "A familiar meal and a calm evening can restore your balance.", 10
				   db "Make time for a check-in with yourself, not only others.", 10, 0
	healthLeo db "Balance work and rest.", 10
				db "A short walk may improve your energy and focus.", 10, 0
	healthVirgo db "A tidy plan helps reduce the mental clutter of the day.", 10
				  db "Remember that recovery belongs on your schedule too.", 10, 0
	healthLibra db "Gentle movement can help you feel more centered today.", 10
				  db "Make one choice that brings a little more balance to your day.", 10, 0
	healthScorpio db "Quiet time gives your concentration a chance to recover.", 10
					db "Let go of one task that can safely wait until tomorrow.", 10, 0
	healthSagittarius db "Time outdoors may lift your spirits and renew your momentum.", 10
						db "Keep the plan flexible and respect your limits.", 10, 0

	luckyTwo db "2", 0
	luckyThree db "3", 0
	luckyFour db "4", 0
	luckyFive db "5", 0
	luckySix db "6", 0
	luckySeven db "7", 0
	luckyEight db "8", 0
	luckyNine db "9", 0
	luckyEleven db "11", 0
	colorSilver db "Silver", 0
	colorBlue db "Blue", 0
	colorSeaGreen db "Sea Green", 0
	colorRed db "Red", 0
	colorGreen db "Green", 0
	colorYellow db "Yellow", 0
	colorWhite db "White", 0
	colorGold db "Gold", 0
	colorNavy db "Navy", 0
	colorPink db "Pink", 0
	colorMaroon db "Maroon", 0
	colorTurquoise db "Turquoise", 0

	signNames dd signCapricorn, signAquarius, signPisces, signAries
			  dd signTaurus, signGemini, signCancer, signLeo
			  dd signVirgo, signLibra, signScorpio, signSagittarius
	signElements dd elementEarth, elementAir, elementWater, elementFire
				 dd elementEarth, elementAir, elementWater, elementFire
				 dd elementEarth, elementAir, elementWater, elementFire
	signSymbols dd symbolGoat, symbolWaterBearer, symbolFish, symbolRam
				dd symbolBull, symbolTwins, symbolCrab, symbolLion
				dd symbolMaiden, symbolScales, symbolScorpion, symbolArcher
	signPersonalities dd personalityCapricorn, personalityAquarius
					  dd personalityPisces, personalityAries
					  dd personalityTaurus, personalityGemini
					  dd personalityCancer, personalityLeo
					  dd personalityVirgo, personalityLibra
					  dd personalityScorpio, personalitySagittarius
	signArts dd artCapricorn, artAquarius, artPisces, artAries
			 dd artTaurus, artGemini, artCancer, artLeo
			 dd artVirgo, artLibra, artScorpio, artSagittarius

	cutoffDays dd 19, 18, 20, 19, 20, 20, 22, 22, 22, 22, 21, 21
	signsBeforeCutoff dd 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
	signsAfterCutoff dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0
	monthMaxDays dd 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31

	loveMessages dd loveCapricorn, loveAquarius, lovePisces, loveAries
				 dd loveTaurus, loveGemini, loveCancer, loveLeo
				 dd loveVirgo, loveLibra, loveScorpio, loveSagittarius
	careerMessages dd careerCapricorn, careerAquarius, careerPisces, careerAries
				   dd careerTaurus, careerGemini, careerCancer, careerLeo
				   dd careerVirgo, careerLibra, careerScorpio, careerSagittarius
	healthMessages dd healthCapricorn, healthAquarius, healthPisces, healthAries
				   dd healthTaurus, healthGemini, healthCancer, healthLeo
				   dd healthVirgo, healthLibra, healthScorpio, healthSagittarius
	luckyNumbers dd luckyThree, luckyEleven, luckySeven, luckyNine
				 dd luckySix, luckyFive, luckyTwo, luckyEight
				 dd luckyFour, luckySix, luckyNine, luckyThree
	luckyColors dd colorSilver, colorBlue, colorSeaGreen, colorRed
				 dd colorGreen, colorYellow, colorWhite, colorGold
				 dd colorNavy, colorPink, colorMaroon, colorTurquoise

section .bss
	nameBuffer resb 64
	inputBuffer resb 32
	lineChar resb 1
	readDestination resd 1
	readLimit resd 1
	readCount resd 1
	birthMonth resd 1
	birthDay resd 1
	signIndex resd 1
	menuChoice resd 1

section .text
	global _start

_start:
	call display_welcome
	call get_user_info
	call validate_birthdate
	call determine_zodiac
	call display_zodiac_art

menu_loop:
	call display_menu
	call read_integer
	cmp edx, 1
	jne invalid_menu_choice
	mov [menuChoice], eax
	cmp eax, 6
	je finish_program
	cmp eax, 1
	jl invalid_menu_choice
	cmp eax, 5
	jg invalid_menu_choice
	call show_horoscope
	call ask_return_to_menu
	cmp eax, 1
	je menu_loop
	jmp finish_program

invalid_menu_choice:
	mov esi, invalidChoiceMsg
	call print_string
	jmp menu_loop

finish_program:
	call exit_program

; Write a zero-terminated string whose address is in ESI.
print_string:
	push esi
	mov ecx, esi
	xor edx, edx
print_length_loop:
	cmp byte [ecx], 0
	je print_length_done
	inc ecx
	inc edx
	jmp print_length_loop
print_length_done:
	pop ecx
	mov eax, 4
	mov ebx, 1
	int 0x80
	ret

; Read one complete line into EDI, storing at most ECX characters.
read_line:
	mov [readDestination], edi
	mov [readLimit], ecx
	mov dword [readCount], 0
read_line_loop:
	mov eax, 3
	xor ebx, ebx
	mov ecx, lineChar
	mov edx, 1
	int 0x80
	cmp eax, 0
	jle read_line_done
	cmp byte [lineChar], 10
	je read_line_done
	cmp byte [lineChar], 13
	je read_line_loop
	mov eax, [readCount]
	cmp eax, [readLimit]
	jge read_line_loop
	mov edi, [readDestination]
	add edi, eax
	mov al, [lineChar]
	mov [edi], al
	inc dword [readCount]
	jmp read_line_loop
read_line_done:
	mov edi, [readDestination]
	mov eax, [readCount]
	mov byte [edi + eax], 0
	ret

; Parse a signed decimal integer. EAX is the value and EDX is 1 when valid.
read_integer:
	mov edi, inputBuffer
	mov ecx, 30
	call read_line
	mov esi, inputBuffer
	xor eax, eax
	xor ebx, ebx
	mov edx, 1
	cmp byte [esi], '-'
	jne check_plus_sign
	mov edx, -1
	inc esi
	jmp parse_integer_digits
check_plus_sign:
	cmp byte [esi], '+'
	jne parse_integer_digits
	inc esi
parse_integer_digits:
	movzx ecx, byte [esi]
	cmp ecx, 0
	je parse_integer_done
	cmp ecx, '0'
	jl parse_integer_invalid
	cmp ecx, '9'
	jg parse_integer_invalid
	imul eax, eax, 10
	jo parse_integer_invalid
	sub ecx, '0'
	add eax, ecx
	jo parse_integer_invalid
	inc ebx
	inc esi
	jmp parse_integer_digits
parse_integer_done:
	cmp ebx, 0
	je parse_integer_invalid
	imul eax, edx
	mov edx, 1
	ret
parse_integer_invalid:
	xor eax, eax
	xor edx, edx
	ret

display_welcome:
	mov esi, welcomeBanner
	call print_string
	mov esi, welcomeArt
	call print_string
	mov esi, discoverText
	call print_string
	ret

get_user_info:
get_name_again:
	mov esi, namePrompt
	call print_string
	mov edi, nameBuffer
	mov ecx, 63
	call read_line
	cmp eax, 0
	je get_name_again
	mov esi, monthPrompt
	call print_string
	call read_integer
	mov [birthMonth], eax
	mov esi, dayPrompt
	call print_string
	call read_integer
	mov [birthDay], eax
	ret

validate_birthdate:
validate_month_again:
	mov eax, [birthMonth]
	cmp eax, 1
	jl invalid_month
	cmp eax, 12
	jg invalid_month
	jmp validate_day
invalid_month:
	mov esi, invalidMonthMsg
	call print_string
	mov esi, monthPrompt
	call print_string
	call read_integer
	mov [birthMonth], eax
	jmp validate_month_again
validate_day:
	mov eax, [birthDay]
	cmp eax, 1
	jl invalid_date
	mov ecx, [birthMonth]
	dec ecx
	mov ebx, [monthMaxDays + ecx * 4]
	cmp eax, ebx
	jg invalid_date
	ret
invalid_date:
	mov esi, invalidDateMsg
	call print_string
	mov esi, monthPrompt
	call print_string
	call read_integer
	mov [birthMonth], eax
	mov esi, dayPrompt
	call print_string
	call read_integer
	mov [birthDay], eax
	jmp validate_month_again

determine_zodiac:
	mov eax, [birthMonth]
	dec eax
	mov ebx, eax
	mov ecx, [cutoffDays + ebx * 4]
	mov eax, [birthDay]
	cmp eax, ecx
	jle zodiac_before_cutoff
	mov eax, [signsAfterCutoff + ebx * 4]
	mov [signIndex], eax
	ret
zodiac_before_cutoff:
	mov eax, [signsBeforeCutoff + ebx * 4]
	mov [signIndex], eax
	ret

display_zodiac_art:
	mov esi, zodiacBanner
	call print_string
	mov eax, [signIndex]
	mov esi, [signArts + eax * 4]
	call print_string
	mov esi, zodiacNameLabel
	call print_string
	mov eax, [signIndex]
	mov esi, [signNames + eax * 4]
	call print_string
	mov esi, lineFeed
	call print_string
	mov esi, elementLabel
	call print_string
	mov eax, [signIndex]
	mov esi, [signElements + eax * 4]
	call print_string
	mov esi, lineFeed
	call print_string
	mov esi, symbolLabel
	call print_string
	mov eax, [signIndex]
	mov esi, [signSymbols + eax * 4]
	call print_string
	mov esi, lineFeed
	call print_string
	mov esi, personalityLabel
	call print_string
	mov eax, [signIndex]
	mov esi, [signPersonalities + eax * 4]
	call print_string
	mov esi, lineFeed
	call print_string
	ret

display_menu:
	mov esi, menuBanner
	call print_string
	ret

show_horoscope:
	mov eax, [menuChoice]
	cmp eax, 1
	je show_love
	cmp eax, 2
	je show_career
	cmp eax, 3
	je show_health
	cmp eax, 4
	je show_lucky
	call display_zodiac_art
	ret
show_love:
	mov esi, loveHeading
	call print_string
	mov eax, [signIndex]
	mov esi, [signNames + eax * 4]
	call print_string
	mov esi, commaSpace
	call print_string
	mov eax, [signIndex]
	mov esi, [loveMessages + eax * 4]
	call print_string
	ret
show_career:
	mov esi, careerHeading
	call print_string
	mov eax, [signIndex]
	mov esi, [signNames + eax * 4]
	call print_string
	mov esi, commaSpace
	call print_string
	mov eax, [signIndex]
	mov esi, [careerMessages + eax * 4]
	call print_string
	ret
show_health:
	mov esi, healthHeading
	call print_string
	mov eax, [signIndex]
	mov esi, [signNames + eax * 4]
	call print_string
	mov esi, commaSpace
	call print_string
	mov eax, [signIndex]
	mov esi, [healthMessages + eax * 4]
	call print_string
	ret
show_lucky:
	mov esi, luckyHeading
	call print_string
	mov esi, luckyNumberLabel
	call print_string
	mov eax, [signIndex]
	mov esi, [luckyNumbers + eax * 4]
	call print_string
	mov esi, lineFeed
	call print_string
	mov esi, luckyColorLabel
	call print_string
	mov eax, [signIndex]
	mov esi, [luckyColors + eax * 4]
	call print_string
	mov esi, lineFeed
	call print_string
	ret

ask_return_to_menu:
ask_return_again:
	mov esi, returnPrompt
	call print_string
	mov edi, inputBuffer
	mov ecx, 30
	call read_line
	mov al, [inputBuffer]
	cmp al, 'Y'
	je return_yes
	cmp al, 'y'
	je return_yes
	cmp al, 'N'
	je return_no
	cmp al, 'n'
	je return_no
	mov esi, invalidReturnMsg
	call print_string
	jmp ask_return_again
return_yes:
	mov eax, 1
	ret
return_no:
	xor eax, eax
	ret

exit_program:
	mov esi, exitMessage
	call print_string
	mov esi, exitArt
	call print_string
	mov eax, 1
	xor ebx, ebx
	int 0x80
