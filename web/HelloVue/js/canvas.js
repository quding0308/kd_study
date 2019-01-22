
"use strict";

function draw2D() {
    console.log("begin draw");

    let canvas = document.getElementById('mycanvas');
    let ctx = canvas.getContext('2d');

    ctx.fillStyle = "#ff00ff";
    ctx.fillRect(10, 10, 100, 100);
    ctx.clearRect(20, 20, 30, 30);
    ctx.strokeStyle = "#0000ff";
    ctx.strokeRect(150, 10, 55, 50);

    // 绘制路径
    ctx.strokeStyle = "#000000";
    ctx.beginPath();
    ctx.moveTo(75, 75);
    ctx.lineTo(100, 75);
    ctx.lineTo(100, 25);
    ctx.lineTo(75, 75);
    ctx.stroke();
    ctx.closePath();

    let ball = {
        x: 100,
        y: 100,
        radius: 25,
        color: 'blue',
        draw: function() {
            ctx.beginPath();
            ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2, true);
            ctx.closePath();
            ctx.fillStyle = this.color;
            ctx.fill();
        }
    };
    ball.draw();

    console.log("end draw");
}