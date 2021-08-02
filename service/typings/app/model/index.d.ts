// This file is created by egg-ts-helper@1.25.8
// Do not modify this file!!!!!!!!!

import 'egg';
import ExportTAchieve from '../../../app/model/t_achieve';
import ExportTGoods from '../../../app/model/t_goods';
import ExportTGrade from '../../../app/model/t_grade';
import ExportTMedal from '../../../app/model/t_medal';
import ExportTPower from '../../../app/model/t_power';
import ExportTRecord from '../../../app/model/t_record';
import ExportTSorce from '../../../app/model/t_sorce';
import ExportTUser from '../../../app/model/t_user';
import ExportTWish from '../../../app/model/t_wish';

declare module 'egg' {
  interface IModel {
    TAchieve: ReturnType<typeof ExportTAchieve>;
    TGoods: ReturnType<typeof ExportTGoods>;
    TGrade: ReturnType<typeof ExportTGrade>;
    TMedal: ReturnType<typeof ExportTMedal>;
    TPower: ReturnType<typeof ExportTPower>;
    TRecord: ReturnType<typeof ExportTRecord>;
    TSorce: ReturnType<typeof ExportTSorce>;
    TUser: ReturnType<typeof ExportTUser>;
    TWish: ReturnType<typeof ExportTWish>;
  }
}
