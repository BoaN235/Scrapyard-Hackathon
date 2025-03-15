class TitleScreen {
    constructor() {
        this.startButton = document.getElementById('startButton');
        this.startButton.addEventListener('click', this.start.bind(this));
    }

    start() {
        window.location.href = 'Game.html'; // Replace 'Game.html' with the actual file name
    }
}

const titleScreen = new TitleScreen();