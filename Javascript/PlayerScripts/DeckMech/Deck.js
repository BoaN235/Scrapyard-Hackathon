export class Deck {
    constructor() {
      this.cards = [];
      this.discards = [];
    }
  
    addCard(card) {
      this.cards.push(card);
    }
  
    shuffle() {
      this.cards.sort(() => Math.random() - 0.5);
    }
  
    drawCard() {
      return this.cards.pop();
    }
  
    discardCard(card) {
      const index = this.cards.indexOf(card);
      if (index > -1) {
        this.cards.splice(index, 1);
        this.discards.push(card);
      }
    }
  }