using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace VetConnect_v1.Migrations
{
    /// <inheritdoc />
    public partial class nuevabase : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Citas_Mascotas_MascotaId",
                table: "Citas");

            migrationBuilder.DropForeignKey(
                name: "FK_Citas_Veterinarios_VeterinarioId",
                table: "Citas");

            migrationBuilder.DropForeignKey(
                name: "FK_Configuraciones_Usuarios_UsuarioId",
                table: "Configuraciones");

            migrationBuilder.DropForeignKey(
                name: "FK_Mascotas_Usuarios_UsuarioId",
                table: "Mascotas");

            migrationBuilder.DropForeignKey(
                name: "FK_Servicios_Mascotas_MascotaId",
                table: "Servicios");

            migrationBuilder.DropForeignKey(
                name: "FK_Servicios_Veterinarios_VeterinarioId",
                table: "Servicios");

            migrationBuilder.DropForeignKey(
                name: "FK_TicketsSoporte_Usuarios_UsuarioId",
                table: "TicketsSoporte");

            migrationBuilder.DropPrimaryKey(
                name: "PK_TicketsSoporte",
                table: "TicketsSoporte");

            migrationBuilder.DropColumn(
                name: "Especialidad",
                table: "Usuarios");

            migrationBuilder.RenameTable(
                name: "TicketsSoporte",
                newName: "TicketSoporte");

            migrationBuilder.RenameColumn(
                name: "ClinicaId",
                table: "Usuarios",
                newName: "VeterinarioId");

            migrationBuilder.RenameIndex(
                name: "IX_TicketsSoporte_UsuarioId",
                table: "TicketSoporte",
                newName: "IX_TicketSoporte_UsuarioId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_TicketSoporte",
                table: "TicketSoporte",
                column: "TicketId");

            migrationBuilder.CreateIndex(
                name: "IX_Usuarios_VeterinarioId",
                table: "Usuarios",
                column: "VeterinarioId");

            migrationBuilder.AddForeignKey(
                name: "FK_Citas_Mascotas_MascotaId",
                table: "Citas",
                column: "MascotaId",
                principalTable: "Mascotas",
                principalColumn: "MascotaId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Citas_Veterinarios_VeterinarioId",
                table: "Citas",
                column: "VeterinarioId",
                principalTable: "Veterinarios",
                principalColumn: "VeterinarioId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Configuraciones_Usuarios_UsuarioId",
                table: "Configuraciones",
                column: "UsuarioId",
                principalTable: "Usuarios",
                principalColumn: "UsuarioId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Mascotas_Usuarios_UsuarioId",
                table: "Mascotas",
                column: "UsuarioId",
                principalTable: "Usuarios",
                principalColumn: "UsuarioId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Servicios_Mascotas_MascotaId",
                table: "Servicios",
                column: "MascotaId",
                principalTable: "Mascotas",
                principalColumn: "MascotaId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Servicios_Veterinarios_VeterinarioId",
                table: "Servicios",
                column: "VeterinarioId",
                principalTable: "Veterinarios",
                principalColumn: "VeterinarioId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_TicketSoporte_Usuarios_UsuarioId",
                table: "TicketSoporte",
                column: "UsuarioId",
                principalTable: "Usuarios",
                principalColumn: "UsuarioId");

            migrationBuilder.AddForeignKey(
                name: "FK_Usuarios_Veterinarios_VeterinarioId",
                table: "Usuarios",
                column: "VeterinarioId",
                principalTable: "Veterinarios",
                principalColumn: "VeterinarioId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Citas_Mascotas_MascotaId",
                table: "Citas");

            migrationBuilder.DropForeignKey(
                name: "FK_Citas_Veterinarios_VeterinarioId",
                table: "Citas");

            migrationBuilder.DropForeignKey(
                name: "FK_Configuraciones_Usuarios_UsuarioId",
                table: "Configuraciones");

            migrationBuilder.DropForeignKey(
                name: "FK_Mascotas_Usuarios_UsuarioId",
                table: "Mascotas");

            migrationBuilder.DropForeignKey(
                name: "FK_Servicios_Mascotas_MascotaId",
                table: "Servicios");

            migrationBuilder.DropForeignKey(
                name: "FK_Servicios_Veterinarios_VeterinarioId",
                table: "Servicios");

            migrationBuilder.DropForeignKey(
                name: "FK_TicketSoporte_Usuarios_UsuarioId",
                table: "TicketSoporte");

            migrationBuilder.DropForeignKey(
                name: "FK_Usuarios_Veterinarios_VeterinarioId",
                table: "Usuarios");

            migrationBuilder.DropIndex(
                name: "IX_Usuarios_VeterinarioId",
                table: "Usuarios");

            migrationBuilder.DropPrimaryKey(
                name: "PK_TicketSoporte",
                table: "TicketSoporte");

            migrationBuilder.RenameTable(
                name: "TicketSoporte",
                newName: "TicketsSoporte");

            migrationBuilder.RenameColumn(
                name: "VeterinarioId",
                table: "Usuarios",
                newName: "ClinicaId");

            migrationBuilder.RenameIndex(
                name: "IX_TicketSoporte_UsuarioId",
                table: "TicketsSoporte",
                newName: "IX_TicketsSoporte_UsuarioId");

            migrationBuilder.AddColumn<string>(
                name: "Especialidad",
                table: "Usuarios",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddPrimaryKey(
                name: "PK_TicketsSoporte",
                table: "TicketsSoporte",
                column: "TicketId");

            migrationBuilder.AddForeignKey(
                name: "FK_Citas_Mascotas_MascotaId",
                table: "Citas",
                column: "MascotaId",
                principalTable: "Mascotas",
                principalColumn: "MascotaId");

            migrationBuilder.AddForeignKey(
                name: "FK_Citas_Veterinarios_VeterinarioId",
                table: "Citas",
                column: "VeterinarioId",
                principalTable: "Veterinarios",
                principalColumn: "VeterinarioId");

            migrationBuilder.AddForeignKey(
                name: "FK_Configuraciones_Usuarios_UsuarioId",
                table: "Configuraciones",
                column: "UsuarioId",
                principalTable: "Usuarios",
                principalColumn: "UsuarioId");

            migrationBuilder.AddForeignKey(
                name: "FK_Mascotas_Usuarios_UsuarioId",
                table: "Mascotas",
                column: "UsuarioId",
                principalTable: "Usuarios",
                principalColumn: "UsuarioId");

            migrationBuilder.AddForeignKey(
                name: "FK_Servicios_Mascotas_MascotaId",
                table: "Servicios",
                column: "MascotaId",
                principalTable: "Mascotas",
                principalColumn: "MascotaId");

            migrationBuilder.AddForeignKey(
                name: "FK_Servicios_Veterinarios_VeterinarioId",
                table: "Servicios",
                column: "VeterinarioId",
                principalTable: "Veterinarios",
                principalColumn: "VeterinarioId");

            migrationBuilder.AddForeignKey(
                name: "FK_TicketsSoporte_Usuarios_UsuarioId",
                table: "TicketsSoporte",
                column: "UsuarioId",
                principalTable: "Usuarios",
                principalColumn: "UsuarioId");
        }
    }
}
