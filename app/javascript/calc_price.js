function calc_price (){
  const itemPrice  = document.getElementById("item-price");
  itemPrice.addEventListener('input', () => {
    const inputPrice = itemPrice.value;
    const salesFee = document.getElementById("add-tax-price");
    const salesProfit = document.getElementById("profit");
    salesFee.innerHTML = `${ Math.floor(inputPrice * 0.1).toLocaleString() }`;
    salesProfit.innerHTML = `${ Math.floor(inputPrice * 0.9).toLocaleString() }`;
  });
};

window.addEventListener('load', calc_price);
