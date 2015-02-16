local PLUGIN=ES.Plugin()
PLUGIN:SetInfo("Jokes",
"Being funny has never been so easy.",
"Excl")

PLUGIN:AddCommand("joke",function(p,a)
	if not p or not p:IsValid() then return 
	elseif p:ESGetVIPTier() < 1 then
		p:ChatPrint("You must have bronze VIP to tell funny jokes.")
		return
	elseif (p.esNextJoke and p.esNextJoke > CurTime()) then
		p:ChatPrint("Wait "..math.Round(p.esNextJoke - CurTime()).." seconds before telling another funny joke.")
		return
	end

	p.esNextJoke = CurTime() + 30

	net.Start("ESFunny") net.Send(p)

	p:ESAddAchievementProgress("funny",1)
end)
PLUGIN:AddFlag(EXCL_PLUGIN_FLAG_NODEFAULTDISABLED)
PLUGIN:AddFlag(EXCL_PLUGIN_FLAG_NOCANDISABLE)
PLUGIN()

if SERVER then
	util.AddNetworkString("ESFunny")
elseif CLIENT then
	local funnyjokes = {"Why did the man put his money in the freezer? He wanted cold hard cash!",
"Heh, javascript!",
"What did the porcupine say to the cactus? \"Is that you mommy? \"",
"What do you get when you cross a snowman with a vampire? Frostbite.",
"How do crazy people go through the forest? They take the psycho path.",
"What do prisoners use to call each other? Cell phones.",
"What do you get from a pampered cow? Spoiled milk.",
"Where do polar bears vote? The North Poll",
"What did Geronimo say when he jumped out of the airplane? ME!!!",
"Where do snowmen keep their money? In snow banks.",
"What's brown and sticky? A stick.",
"Why do sea-gulls fly over the sea? Because if they flew over the bay they would be bagels!",
"What dog keeps the best time? A watch dog.",
"Why did the tomato turn red? It saw the salad dressing!",
"What did the grape do when it got stepped on? It let out a little wine!",
"How do you make a tissue dance? Put a little boogey in it!",
"Where do bees go to the bathroom? At the BP station!",
"What did the judge say when the skunk walked in the court room? Odor in the court.",
"What did the water say to the boat? Nothing, it just waved.",
"What did the fish say when he swam into the wall? Dam!",
"Why don't skeletons fight each other? They don't have the guts.",
"What has four legs but can't walk? A table!",
"Why did the turtle cross the road? To get to the Shell station!",
"What did the ground say to the earthquake? You crack me up!",
"What do you get when you cross a cow and a duck? Milk and quackers!",
"Why did the elephant eat the candle? He wanted a light snack!",
"Why is the letter \"G\" scary? It turns a host into a ghost",
"What has 4 eyes but no face? Mississippi!",
"What did the spider do on the computer? Made a website!",
"What letters are not in the alphabet? The ones in the mail, of course!",
"Why was 6 afraid of 7? Because 789!",
"Why did the cookie go to the hospital? Because it felt crummy.",
"How do you know carrots are good for your eyes? Because you never see rabbits wearing glasses!",
"What do you call a pony with a sore throat? A little horse",
"What do you call cheese that is not yours? Nacho Cheese",
"Why did the sheep say \"moo\"? It was learning a new language!",
"What streets do ghosts haunt? Dead ends!",
"What is an astronaut's favorite place on a computer? The Space bar!",
"What exam do young witches have to pass? A spell-ing test!",
"Why did the boy eat his homework? Because his teacher said it was a piece of cake!",
"Why is Basketball such a messy sport? Because you dribble on the floor!",
"What is the best day to go to the beach? Sunday, of course!",
"What bow can't be tied? A rainbow!",
"What happens if you eat yeast and shoe polish? Every morning you'll rise and shine!",
"What does a teddy bear put in his house? Fur-niture!",
"Q.What season is it when you are on a trampoline? A.Spring time.",
"What happens to cows during an earthquake? They give milk shakes!",
"Why did the jelly wobble? Because it saw the milk shake!",
"What do you call a girl who is always in the bookies? Betty!",
"Where do cows go on holiday? Moo York",
"Where did the computer go to dance? To a disc-o.",
"What do you call a man who rolls in the leaves? Russel",
"What has one head, one foot and four legs? A Bed",
"Why didn't the chicken cross the road? He was a chicken.",
"What is the difference between a school teacher and a train? The teacher says spit your gum out and the train says \"chew chew chew\".",
"Why did the birdie go to the hospital? To get a tweetment.",
"What do you call someone who is afraid of Santa? A Clausterphobic",
"Why was the guy looking for the food on his friend? Because his friend said its on me.",
"Did you hear the joke about the roof? Never mind, it's over your head!",
"What do you call a cow eating grass in a paddock? A lawn mooer",
"Why didn't the skeleton go to the dance? Because he had no-body to go with.",
"What did the penny say to the other penny? We make perfect cents.",
"Why did the man with one hand cross the road? To get to the second hand shop.",
"Why did the picture go to jail? Because it was framed.",
"What are two things you cannot have for breakfast? Lunch and dinner.",
"Why did the boy sprinkle sugar on his pillow before he went to sleep? So he could have sweet dreams.",
"Why did the robber take a bath? Because he wanted to make a clean getaway.",
"What did the judge say to the dentist? Do you swear to pull the tooth, the whole tooth and nothing but the tooth.",
"What do you call a bear with no socks on? Bare-foot.",
"What can you serve but never eat? A volleyball.",
"What did one teddy bear say to the other teddy bear when he offered him some dessert? No thank you, I am stuffed.",
"What kind of shoes do all spies wear? Sneakers.",
"What did one wall say to the other wall? I'll meet you at the corner.",
"Why did the soccer player bring string to the game? So he could tie the score.",
"Why is a baseball team similar to a muffin? They both depend on the batter.",
"What did the alien say to the garden? Take me to your weeder.",
"Have you heard the joke about the butter? I butter not tell you, it might spread.",
"How do baseball players stay cool? Sit next to their fans.",
"What gets wetter the more it dries? A towel.",
"Why was the math book sad? Because it had too many problems.",
"What runs but doesn't get anywhere? A refrigerator.",
"How do you catch a squirrel? Climb a tree and act like a nut!",
"What do you do with a blue whale? Try to cheer him up! ",
"How do you communicate with a fish? Drop him a line!",
"Where do sheep go to get haircuts? To the Baa Baa shop!",
"What does a shark eat with peanut butter? Jellyfish!",
"Why was the pelican kicked out of the hotel? Because he had a big bill!",
"What do cats eat for breakfast? Mice Crispies!",
"What kind of dog tells time? A watch dog!",
"Why can't a leopard hide? Because he's always spotted!",
"What do you give a dog with a fever? Mustard, its the best thing for a hot dog!",
"What do you get when you cross a cat with a lemon? A sour puss!",
"Why do birds fly south for the winter? Its easier than walking!",
"What kind of key opens a banana? A monkey!",
"How do you know that carrots are good for your eyesight? Have you ever seen a rabbit wearing glasses? ",
"Why does a hummingbird hum? It doesn't know the words!",
"Why are some fish at the bottom of the ocean? Because they dropped out of school!",
"What goes up and down but doesn't move? The temperature!",
"What two days of the week start with the letter \"T\"? Today and Tomorrow!",
"Which weighs more, a ton of feathers or a ton of bricks? Neither, they both weigh a ton!",
"What has four eyes but can't see? Mississippi!",
"Where does wood come from? A guy named woody.",
"What has one horn and gives milkA milk truck.",
"Where do bulls get their messagesOn a bull-etin board.",
"What do bulls do when they go shopping? They CHARGE!",
"Why were the giant's fingers only eleven inches long? Because if they were twelve inches long, they'd be a foot.",
"What is invisible and smells like carrots? Bunny Farts!",
"What runs but can't walk? The faucet!",
"What kind of bed does a mermaid sleep in? A water bed!",
"What kind of crackers do firemen like in their soup? Firecrackers!",
"What did the teddy bear say when he was offered dessert? No thanks, I'm stuffed!",
"Why did the barber win the race? Because he took a short cut.",
"What's taken before you get it? Your picture.",
"Why did the tree go to the dentist? To get a root canal.",
"Why did the child study in the airplane? He wanted a higher education!",
"Why was the broom late? It over swept!",
"What did the fireman's wife get for Christmas? A ladder in her stocking!",
"What did one virus say to another? Stay away, I think I've got penicillin!",
"What did the tie say to the hat? You go on ahead and I'll hang around!",
"What pet makes the loudest noise? A trum-pet!",
"What is a tornado? Mother nature doing the twist!",
"Why did the boy tiptoe past the medicine cabinet? He didn't want to wake the sleeping pills!",
"How do you tease fruit? Banananananananana!",
"Why did Goofy put a clock under his desk? Because he wanted to work over-time!",
"Why did Tommy throw the clock out of the window? Because he wanted to see time fly!",
"How does a moulded fruit-flavoured dessert answer the phone? Jell-o!",
"When do you stop at green and go at red? When you're eating a watermelon!",
"How did the farmer mend his pants? With cabbage patches!",
"Why don't they serve chocolate in prison? Because it makes you break out!",
"What do you call artificial spaghetti? Mockaroni!",
"What happens to a hamburger that misses a lot of school? He has a lot of ketchup time!",
"Why did the man at the orange juice factory lose his job? He couldn't concentrate!",
"How do you repair a broken tomato? Tomato Paste!",
"Why did the baby strawberry cry? Because his parents were in a jam!",
"What did the hamburger name his daughter? Patty!",
"What kind of egg did the bad chicken lay? A deviled egg!",
"What kind of key opens the door on Thanksgiving? A turkey!",
"What kind of cake do you get at a cafeteria? A stomach-cake!",
"Why did the cookie go to the hospital? He felt crummy!",
"When does a cart come before a horse? In the dictionary!",
"Why were the teacher's eyes crossed? She couldn't control her pupils!",
"What do you get when you put a fish and an elephant together? Swimming trunks.",
"What goes up when the rain comes down? An umbrella.",
"What disappears when you stand up? Your lap.",
"What did the big firecracker say to the little firecracker? My pop is bigger than yours.",
"What did the big chimney say to the small chimney? You are too little to smoke.",
"What do you call a surgeon with eight arms? A doctopus!",
"Why did the teacher jump into the lake? Because she wanted to test the waters!",
"Why did the belt go to jail? Because it held up a pair of pants!",
"What is the center of gravity? The letter V!",
"What did the stamp say to the envelope? Stick with me and we will go places!",
"What sort of star is dangerous? A shooting star!",
"Why did the teacher write the lesson on the windows? He wanted the lesson to be very clear!",
"What kind of lights did Noah use on the Ark? Flood lights!",
"What do computers do when they get hungry? They eat chips!",
"Why don't you see giraffes in elementary school? Because they're all in High School!",
"Which is the longest word in the dictionary? \"Smiles\", because there is a mile between each \"s\"!",
"Which month do soldiers hate most? The month of March!",
"What did the painter say to the wall? One more crack like that and I'll plaster you!",
"Why do golfers wear two pairs of pants? In case they get a hole in one!",
"What did the the tie say to the hat? You go on a head, I'll just hang around!",
"What would you call two banana skins? A pair of slippers."
}

	net.Receive("ESFunny",function()
		timer.Simple(1.1,function()
			LocalPlayer():ConCommand("say ^9"..table.Random(funnyjokes).." :D")
		end)
	end)
end
