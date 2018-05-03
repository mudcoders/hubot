# Description:
#   Here comes the Newbie Welcome Wagon, welcoming newbies!
#
# Notes:
#   Update the `welcomes` variable to add new welcome wagon messages, use an
#   array for multi-message welcomes
#
#   To @mention the user, use the `:username:` variable

module.exports = (robot) ->

  welcomes = [
    'Puff the Fractal Dragon whoops and cheers and yells as a strange wooden contraption full of gears and black smoke carries her at a vertiginous pace into the area. Various wooden frames fall out, with many attempts to embroider elegantly the words `Newbie Welcome Wagon`. All fail at their goal catastrophically. Veering and swerving, Puff manages to drive near and not over :username:, and throws a small brilliantly colored bag in their direction. The bag reads `Yo! You\'re cool! Open me!`, which tries to be friendly and fails in an almost-but-not-quite endearing fashion. The wagon hiccups, swerves, and bounces off-stage. A scream is followed by the sound of wood and metal colliding together in a very unfriendly fashion.',
    'Puff yawns, walks in, pours some coffee in a cup, then sets it down and goes back to sleep. The *Newbie Welcome Wagon* clicks and whirs as it comes in - a cuckoo clock seems to be powering it. It starts to shake and beep, then it starts to eject things. A frozen popsicle, a blue thaumic funnel, a plastic pregnant belly, and a small clay tablet are among the identifiable objects. Finally, a small lace bag lands gently with a delicate *plot* in front of :username:. The bag reads "~Eat me~ ~Drink me~ ~Cook me~ Open me."',
    [
      'Puff the Fractal Dragon runs out and comes back in, pushing in an old, grizzled wagon. The wagon squeaks, and its contents are covered by a tarp. In front of the wagon hangs a sign that says `Hours of operation: `. Puff settles the wagon on the ground then leans on it to wipe her brow.',
      'Puff circles the *Newbie Welcome Wagon* cautiously, assessing it. Finally, she decides. Puff rushes in, lifts the tarp, and hauls herself in underneath. She seems to be struggling with something much larger than her.',
      'A large grandfather clock suddenly jumps out of the wagon and falls three feet away from :username:. It crashes and breaks into pieces. Springs, strangely enough, actually make *boing* noises as they bounce away.',
      'Puff screams "YEAH? WELL YOUR DOG MUST HAVE TAUGHT YOU ALL THAT YOU KNOW!".'
    ],
    'runs out and comes back in, pushing in an old, grizzled wagon. The wagon squeaks, and its contents are covered by a tarp. In front of the wagon hangs a sign that says `Hours of operation: `. Puff settles the wagon on the ground then leans on it to wipe her brow.',
    [
      'Puff the Fractal Dragon goes to fetch the *Newbie Welcome Wagon*. It squeaks horribly, and he visibly pains under the strain. Squeak.. Squeak..',
      'The wagon has a wooden board hastily nailed to the side on which one can read, `Mary Poppins wishes she had me`.',
      'Puff takes out blocks of wood and places them by the wheels to lock the wagon in place, then she lifts the tarp and disappears underneath, inside the wagon. The sounds of sword fighting can be heard, then a faint cry of "Ow! Not in the face!"',
      'A small *pop* is heard, and a small lead toy soldier falls out of the wagon - or maybe from just in front of the wagon.',
      'Puff emerges from the wagon, wielding a hammer she *definitely* didn\'t have on the way in, swings at something inside and yells "AND STAY DOWN!" then she picks up a small bag and lowers the tarp.',
      'Puff dusts herself off then hands :username: the bag. It is faded and reads "Welcome! Open me!"',
      'Puff whistles a little tune, then uses the hammer to knock out the blocks of wood, and drags the wagon away. Squeak.. Squeak...'
    ],
    [
      'Puff the Fractal Dragon walks in, dragging behind her the *Newbie Welcome Wagon*. It squeaks painfully, and its wheels seem much newer than the rest of the wagon.',
      'Puff lifts the tarp and buries her head underneath. The sound of rummaging comes out, then a rubber chicken with a pulley falls out, followed quickly by what may be a snow globe representation of the universe.',
      'Puff lets out some muffled cursing, then the sound of frenetic hammering comes out, followed strangely by what could be the song of a bird of paradise. Finally, she emerges with a faded bag on which the words "Ur ohsum" are written in Sharpie. She hands the bag to :username: with a big smile.'
    ]
  ]

  robot.enter (res) ->
    welcome = res.random welcomes
    messages = []

    if welcome.constructor != Array
      messages = [
        welcome
      ]
    else
      messages = welcome

    doloop = (i) ->
      # let's add some realism, add a 3-10 second delay between messages
      setTimeout ->
        res.send "_#{messages[i].replace(/:username:/, "<@#{res.message.user.id}>")}_"

        if i < messages.length - 1
          doloop(i + 1)
      , (Math.random() * (10 - 3) + 3) * 1000
    doloop(0)

