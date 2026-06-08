
import time

# --- THE RPG RELAY CHAIN: TURN 1 ---
# Rules: Add your feature, don't delete the core loop, and leave comments!

class Character:
    def __init__(self, name, hp, attack):
        self.name = name
        self.max_hp = hp
        self.current_hp = hp
        self.attack_power = attack

    def is_alive(self):
        return self.current_hp > 0

    def take_damage(self, damage):
        self.current_hp -= damage
        if self.current_hp < 0:
            self.current_hp = 0

    def heal(self, amount):
        self.current_hp += amount
        if self.current_hp > self.max_hp:
            self.current_hp = self.max_hp

def main():
    print("=== WELCOME TO THE RELAY RPG ===")
    print("Prepare for battle!\n")

    # Player and Enemy Setup
    # NEXT PERSON: Maybe add character classes, names, or different weapons?
    player = Character("Hero", hp=100, attack=15)
    enemy = Character("Slime", hp=50, attack=8)

    turn = 1

    # The Main Combat Loop
    while player.is_alive() and enemy.is_alive():
        print(f"\n--- TURN {turn} ---")
        print(f"[{player.name}] HP: {player.current_hp}/{player.max_hp}")
        print(f"[{enemy.name}] HP: {enemy.current_hp}/{enemy.max_hp}\n")

        print("Your turn! What will you do?")
        print("1. Attack")
        print("2. Heal")
        # NEXT PERSON: Add Magic, Items, or Flee options to the menu!

        choice = input("Enter 1 or 2: ")

        if choice == '1':
            # Basic attack logic
            # NEXT PERSON: Add a D&D style dice roll for randomized damage or critical hits!
            damage = player.attack_power
            enemy.take_damage(damage)
            print(f"You strike the {enemy.name} for {damage} damage!")
        
        elif choice == '2':
            # Basic heal logic
            heal_amount = 20
            player.heal(heal_amount)
            print(f"You heal yourself for {heal_amount} HP!")
        
        else:
            print("Invalid choice! You stumble and lose your turn.")

        time.sleep(1) # Adds a little dramatic pause

        # Enemy Turn
        if enemy.is_alive():
            print(f"\nThe {enemy.name} attacks!")
            enemy_damage = enemy.attack_power
            player.take_damage(enemy_damage)
            print(f"The {enemy.name} deals {enemy_damage} damage to you!")
        
        time.sleep(1)
        turn += 1

    # End Game State
    print("\n=== BATTLE OVER ===")
    if player.is_alive():
        print("You won! ...But what lurks ahead?")
        # NEXT PERSON: Add an EXP/level-up system or trigger a second battle here!
    else:
        print("You were defeated. Game Over.")

if __name__ == "__main__":
    main()
