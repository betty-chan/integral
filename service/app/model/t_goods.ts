/* indent size: 2 */

module.exports = app => {
  const DataTypes = app.Sequelize;

  const Model = app.model.define('t_goods', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true
    },
    title: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    value: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    on_shelf: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    limit: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    cover_img: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    other_img: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    description: {
      type: DataTypes.STRING(255),
      allowNull: true
    }
  }, {
    tableName: 't_goods',
    timestamps: false,
  });

  Model.associate = function () {

  }

  return Model;
};
