import { LotteryMBResults } from 'src/lottery/domain/LotteryMBResults';
import { IBet } from './Bet';
import { IAccount } from 'src/account/domain/Account';
import { IContact } from 'src/contact/domain/Contact';
import { IDebt } from 'src/debt/domain/Debt';

export class BetDomainService {
  calculate(
    result: LotteryMBResults,
    bets: IBet[],
    account: IAccount,
    contacts: Map<string, IContact>,
    debts: Map<string, IDebt>, //Các khoản nợ (contacts) của 1 account
  ) {
    for (let i = 0; i < bets.length; i++) {
      const bet: IBet = bets[i];
      const amount = bet.calculate(result);
      if (amount <= 0) continue;
      if (bet.getAccountId == account.getId && contacts.has(bet.getContactId)) {
        const debt = debts.get(bet.getContactId);
        debt.change(amount);
      }
    }
  }
}
