const f = Bun.file("./input");
const lines = (await f.text())
  .split("\n")
  .filter((l) => l !== "")
  .map((l) => l.split(/\s+/).map((n) => parseInt(n)));
let left: number[] = [];
let right: number[] = [];
for (const [l, r] of lines) {
  left.push(l);
  right.push(r);
}
left.sort();
right.sort();
let sum = 0;
for (let i = 0; i < left.length; i++) {
  sum += Math.abs(right[i] - left[i]);
}
console.log(sum);
