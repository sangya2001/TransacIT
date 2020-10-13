import {ethers, Contract} from 'ethers';
import Transaction from './contracts/Transaction.json';

const getBlockchain = () => {
    new Promise((resolve, reject) => {
        window.addEventListener('load', async () => {
            if(window.ethereum) {
                await window.ethereum.enable();
                const provider = new ethers.providers.Web3Provider(window.ethereum);
                const signer = provider.getSigner();

                const transaction = new Contract(
                    Transaction.networks[window.ethereum.networkVersion].address,
                    Transaction.abi,
                    signer
                );

                resolve({provider, transaction});
            }
            else resolve({provider: undefined, transaction: undefined})
        })
    })
}

export default getBlockchain;