class TitleScreen {
    constructor() {
        this.createButton();
    }

    createButton() {
        const button = document.createElement('button');
        button.innerText = 'Click Me';
        button.addEventListener('click', () => {
            alert('Button clicked!');
        });
        document.body.appendChild(button);
    }
}

TitleScreen = new TitleScreen('property1', 'property2');