// Base Card class
export class Card {
    constructor(name, cost) {
        this.name = name;
        this.cost = cost;
    }

    play() {
        console.log(`${this.name} card played!`);
    }
}

// Derived class for a specific type of card
export class AttackCard extends Card {
    constructor(name, cost, damage) {
        super(name, cost);
        this.damage = damage;
    }

    play() {
        super.play();
        console.log(`It deals ${this.damage} damage!`);
    }
}

// Derived class for another type of card
export class HealCard extends Card {
    constructor(name, cost, healing) {
        super(name, cost);
        this.healing = healing;
    }

    play() {
        super.play();
        console.log(`It heals ${this.healing} health!`);
    }
}

